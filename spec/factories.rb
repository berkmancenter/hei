FactoryGirl.define do
  factory :organization do
    factory :berkman do
      name 'Berkman Center for Internet and Society'
      location '23 Everett St, Cambridge, MA 02138'
      phone '617-495-7547'
    end
  end

  factory :contact do
    factory :anita do
      first_name 'Anita'
      last_name 'Patel'
      email 'apatel@cyber.law.harvard.edu'
    end

    factory :ryan do
      first_name 'Ryan'
      last_name 'Westphal'
      email 'rwestphal@cyber.law.harvard.edu'
    end
  end

  factory :project do
    factory :hei do
      title 'Hei'
      description 'Hei, everyone: integrate!'
      repository_url 'https://github.com/berkmancenter/hei'
      app_url ''
      micropost_url ''
      news_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/activity'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/wiki'
      progress 10
      launch_date '2013-09-09'
      conception_date '2012-07-01'
      #contact anita
      #organization berkman
    end
  end
end
