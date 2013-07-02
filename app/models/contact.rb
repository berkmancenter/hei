class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :organization_ids
  
  has_and_belongs_to_many :organizations
  
  validates_presence_of :first_name, :last_name
  validates_presence_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  
  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end
