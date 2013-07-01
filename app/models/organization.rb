class Organization < ActiveRecord::Base
  attr_accessible :location, :name, :phone, :contact_ids
  
  has_and_belongs_to_many :contacts
end
