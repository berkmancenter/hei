require 'factory_girl_rails'

namespace :db do
  task :seed => :environment do
    berkman = FactoryGirl.create( :berkman );
    berkman.save!

    anita = FactoryGirl.create( :anita );
    anita.organizations << berkman;

    ryan = FactoryGirl.create( :ryan );
    ryan.organizations << berkman;

    jen = FactoryGirl.create( :jen );
    jen.organizations << berkman;

    hei = FactoryGirl.create( :hei );
    hei.organization = berkman;
    hei.contact = anita;
    hei.save!

    im = FactoryGirl.create( :im );
    im.organization = berkman;
    im.contact = ryan;
    im.save!

    eda = FactoryGirl.create( :eda );
    eda.organization = berkman;
    eda.contact = jen;
    eda.save!
  end
end
