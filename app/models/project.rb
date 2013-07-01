class Project < ActiveRecord::Base
  attr_accessible :description, :title, :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :organization, :launch_date, :conception_date
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :description, :maximum => 5.kilobytes
  validates_length_of :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :maximum => 1.kilobyte
  validates_format_of :repository_url, :news_url, :documentation_url, :app_url, :micropost_url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true

  acts_as_taggable

  searchable(:include => [:taggings]) do
    text :title, :description, :repository_url, :news_url, :documentation_url
    string :tag_facets_for_indexing, :multiple => true
  end

  def tag_facets_for_indexing
    self.taggings.collect{|tg| "#{tg.context}--#{tg.tag_id}"}
  end

end
