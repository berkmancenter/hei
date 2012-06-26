class Project < ActiveRecord::Base
  attr_accessible :description, :title
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :description, :maximum => 5.kilobytes
  validates_length_of :repository_url, :news_url, :documentation_url, :maximum => 1.kilobyte
  validates_format_of :repository_url, :news_url, :documentation_url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true

  acts_as_taggable

end
