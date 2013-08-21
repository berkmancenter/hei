class Organization < ActiveRecord::Base
  attr_accessible :location, :name, :url, :phone, :contact_ids
  
  has_and_belongs_to_many :contacts
  
  validates_presence_of :name

  validates_length_of :url, :maximum => 1.kilobyte
  validates_format_of :url, :with => /^https?:\/\/[^\.]+\..+$/i, :allow_blank => true, :allow_nil => true
  
  def to_s
    self.name
  end
end
