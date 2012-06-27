namespace :hei do

  desc 'fake data'
  task :fake_data => :environment do
    titles = ['bunny','fluffy','angry','kitten','odd','precise','penguin','whale','ears','turtle','bukket']
    descriptions = ['This is a','serious','One way to','killer feature','market driven','technosavior','intense visuals', 'Enterprise-ready','Open source','GNU/Linux']

    1000.times do
      title = []
      description = []
      (rand(6) + 1).times do
        title << titles[rand(titles.length)]
      end
      (rand(20) + 1).times do
        description << descriptions[rand(descriptions.length)]
      end
      Project.create(:title => title.join(' '), :description => description.join(' ') )
    end
  end

end
