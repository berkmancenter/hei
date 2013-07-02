class Organization < ActiveRecord::Base
  attr_accessible :location, :name, :phone, :contact_ids
  
  has_and_belongs_to_many :contacts
  
  validates_presence_of :name, :phone
  
  def to_s
    self.name
  end
end
