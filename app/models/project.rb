class Project < ActiveRecord::Base
  attr_accessible :title, :description, :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :progress, :launch_date, :conception_date, :contact_id, :organization_id, :tag_list

  belongs_to :organization

  belongs_to :contact

  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :description, :maximum => 5.kilobytes
  validates_length_of :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :maximum => 1.kilobyte
  validates_format_of :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true

  acts_as_taggable_on :tags

  searchable :include => [:taggings], :auto_index => true, :auto_remove => true  do
    text :title, :stored => true
    text :description, :stored => true
    string :repository_url, :stored => true
    string :app_url, :stored => true
    string :micropost_url, :stored => true
    string :tag_list, :multiple => true, :stored => true
  end
end
