namespace :hei do
  desc 'fake data'
  task :fake_data => :environment do
    titles = ['bunny','fluffy','angry','kitten','odd','precise','penguin','whale','ears','turtle','bukket']
    descriptions = ['This is a','serious','One way to','killer feature','market driven','technosavior','intense visuals', 'Enterprise-ready','Open source','GNU/Linux']
    languages = ['perl','ruby','php','java','html','css','javascript']
    platforms = ['web','desktop','infrastructure']

    1000.times do
      title = []
      description = []
      language = []
      platform = []
      (rand(6) + 1).times do
        title << titles[rand(titles.length)]
      end
      (rand(20) + 1).times do
        description << descriptions[rand(descriptions.length)]
      end
      (rand(2) + 1).times do
        language << languages[rand(languages.length)]
      end
      (rand(2) + 1).times do
        platform << platforms[rand(platforms.length)]
      end
      p = Project.new(:title => title.join(' '), :description => description.join(' ') )
      p.set_tag_list_on(:language, language.join(','))
      p.set_tag_list_on(:platform, platform.join(','))
      p.save
    end
  end

end
