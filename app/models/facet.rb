class Facet < ActiveRecord::Base
  attr_accessible :name, :context, :position, :primary
  validates_presence_of :context, :name
  validates_length_of :context, :maximum => 128
  validates_length_of :name, :maximum => 255
  validates_uniqueness_of :context, :name
  validates_format_of :context, :with => /^[a-z_\-]+$/, :message => 'should consist only of lowercase letters, underscores and hyphens.'
  acts_as_list

  scope :primary, where(:primary => true).order('position')
  scope :secondary, where(:primary => false).order('position')

  def self.facet_hash
    hash = {}
    self.all.collect{|f| hash[f.context] = f.attributes}
    hash
  end
end
