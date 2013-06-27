require 'factory_girl_rails'

namespace :db do
  namespace :test do
    task :prepare => :environment do
      project_valid = FactoryGirl.create( :project_valid );
      project_valid.save!
    end
  end
end
