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
    org = Organization.find_or_create_by_name( row[ 4 ] )

    email = row[ 9 ]
    if email == 'Yes'
      email = row[ 3 ]
    elsif email == 'No'
      email = nil
    end

    p = Project.find_or_create_by_title( "#{row[1]} #{row[2]}" )

    p.update_attributes( {
      organization_id: org.id,
      role: row[ 11 ],
      description: row[ 10 ],
      email: email,
      micropost_url: "https://twitter.com/#{row[13]}",
      app_url: row[ 14 ],
      tag_list: row[ 8 ]
    } )
  end
end
