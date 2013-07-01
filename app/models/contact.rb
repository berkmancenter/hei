class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :organization_ids
  
  has_and_belongs_to_many :organizations
end
