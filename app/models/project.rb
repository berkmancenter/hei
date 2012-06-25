class Project < ActiveRecord::Base
  attr_accessible :description, :title
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :description, :maximum => 5.kilobytes

end
