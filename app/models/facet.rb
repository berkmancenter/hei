class Facet < ActiveRecord::Base
  attr_accessible :context, :position
  validates_presence_of :context, :name
  validates_length_of :context, :maximum => 128
  validates_length_of :name, :maximum => 255
  validates_uniqueness_of :context, :name
  validates_format_of :context, :with => /^[a-z_\-]+$/, :message => 'should consist only of lowercase letters, underscores and hyphens.'
  acts_as_list
end
