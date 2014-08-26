class Project < ActiveRecord::Base
  attr_accessible :title, :description, :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :progress, :launch_date, :conception_date, :contact_id, :organization_id, :tag_list, :email, :role

  belongs_to :organization

  belongs_to :contact

  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :description, :maximum => 5.kilobytes
  validates_length_of :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :maximum => 1.kilobyte
  validates_format_of :repository_url, :news_url, :documentation_url, :app_url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true

  if Hei::Application.config.hei[ 'projects_as' ] == 'people'
    validates_format_of :micropost_url, :with => /^https:\/\/twitter.com\/.+$/i, :allow_blank => true, :allow_nil => true, :message => 'Please enter a URL to a Twitter profile'
  else
    validates_format_of :micropost_url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true
  end

  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :allow_blank => true, :allow_nil => true

  acts_as_taggable_on :tags

  searchable :include => [:taggings], :auto_index => true, :auto_remove => true  do
    text :title, :stored => true
    text :description, :stored => true
    text :tag_list
    string :repository_url, :stored => true
    string :app_url, :stored => true
    string :micropost_url, :stored => true
    string :tag_list, :multiple => true, :stored => true
  end

  before_validation {
    self.micropost_url = nil if attribute_present?( 'micropost_url' ) && self.micropost_url == 'https://twitter.com/'
  }

  def self.update_or_create_from_csv_row( row )
    # csv must have already been read from file
    # will create organization if one cannot be found
    org = Organization.find_or_create_by_name( row[ 'Affiliation (Organization)' ] )

    email = row[ "Optional: Do you want the email address you used above made public?  If you'd like a different email address used, please include it here under 'Other'." ]
    if email == 'Yes'
      email = row[ 'Email Address' ]
    elsif email == 'No'
      email = nil
    end

    app_url = row[ 'Optional: Please list a homepage you would like included' ]
    if app_url.present? && !app_url.start_with?( 'http' )
      app_url = "http://#{app_url}"
    end

    title = "#{row[ 'First Name' ]} #{row[ 'Last Name' ]}"
    p = Project.find( :first, :conditions => [ "lower(title) = ?", title.downcase ] ) || Project.create( :title => title)

    p.update_attributes( {
      title: title,
      organization_id: org.id,
      role: row[ 'Role/Title' ],
      description: row[ 'Optional: Tell us more about your work' ],
      email: email,
      micropost_url: "https://twitter.com/#{row[ 'Optional: Please list a twitter handle you would like included' ]}",
      app_url: app_url,
      tag_list: row[ 'Optional: What topics are you interested in? What areas does your work touch upon?' ]
    } )
  end
end
