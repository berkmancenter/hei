require 'factory_girl_rails'

namespace :db do
  task :seed => :environment do
    berkman = FactoryGirl.create( :berkman );
    berkman.save!

    anita = FactoryGirl.create( :anita );
    anita.organizations << berkman;

    ryan = FactoryGirl.create( :ryan );
    ryan.organizations << berkman;

    hei = FactoryGirl.create( :hei );
    hei.organization = berkman;
    hei.contact = anita;
    hei.save!
  end
end
