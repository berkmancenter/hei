# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


Facet.create(
  [
    {:name => 'Programming Language', :context => 'language', :primary => true},
    {:name => 'License', :context => 'license', :primary => false},
    {:name => 'Platform', :context => 'platform', :primary => true},
    {:name => 'Maturity', :context => 'maturity', :primary => false},
    {:name => 'Problem Space', :context => 'problem_space', :primary => false},
    {:name => 'Developers', :context => 'developers', :primary => false}
])

