require 'factory_girl_rails'

namespace :hei do
  task :seed => :environment do
    Project.delete_all
    Contact.delete_all
    Organization.delete_all

    berkman = FactoryGirl.create :berkman
    berkman.save

    librarylab = FactoryGirl.create :librarylab
    librarylab.save

    o_nil_optionals = FactoryGirl.create :o_nil_optionals
    o_nil_optionals.save

    anita = FactoryGirl.create :anita
    anita.organizations << berkman

    ryan = FactoryGirl.create :ryan
    ryan.organizations << berkman

    jen = FactoryGirl.create :jen
    jen.organizations << berkman

    hei = FactoryGirl.create :hei
    hei.organization = berkman
    hei.contact = ryan
    hei.save

    im = FactoryGirl.create :im
    im.organization = berkman
    im.contact = ryan
    im.save

    eda = FactoryGirl.create :eda
    eda.organization = berkman
    eda.contact = jen
    eda.save

    nil_app_url = FactoryGirl.create :nil_app_url
    nil_app_url.organization = berkman
    nil_app_url.save

    nil_contact = FactoryGirl.create :nil_contact
    nil_contact.organization = berkman
    nil_contact.save

    nil_description = FactoryGirl.create :nil_description
    nil_description.contact = ryan
    nil_description.organization = berkman
    nil_description.save

    unused_tag = FactoryGirl.create :unused_tag
    unused_tag.organization = berkman
    unused_tag.save

    Project.reindex
    Sunspot.commit
  end
end
