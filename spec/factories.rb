FactoryGirl.define do
  factory :organization do
    factory :berkman do
      name 'Berkman Center for Internet and Society'
      location '23 Everett St, Cambridge, MA 02138'
      phone '617-495-7547'
    end
  end

  factory :project do
    factory :project_valid do
      title 'Hei'
      description 'Hei, Everyone: Integrate!'
      repository_url 'https://github.com/berkmancenter/devise_harvard_auth_proxy'
      news_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/activity'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/wiki'
      app_url ''
      micropost_url ''
      launch_date '2013-09-09'
      conception_date '2012-07-01'
    end
  end
end
