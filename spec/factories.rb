FactoryGirl.define do
  factory :project do
    factory :project_valid do
      title 'Hei'
      description 'Hey, Everyone: Integrate'
      repository_url 'https://github.com/berkmancenter/devise_harvard_auth_proxy'
      news_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/activity'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/wiki'
    end
  end
end
