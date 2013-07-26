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

    factory :jen do
      first_name 'Jen'
      last_name 'Jubinville'
      email 'jjubinville@cyber.law.harvard.edu'
    end
  end

  factory :project do
    factory :hei do
      title 'Hei'
      description 'Hei everyone! Integrate!'
      repository_url 'https://github.com/berkmancenter/hei'
      app_url ''
      micropost_url ''
      news_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/activity'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/hei/wiki'
      progress 10
      launch_date '2013-09-09'
      conception_date '2012-07-01'
      tag_list [['web', 'html5', 'productivity']]
      #contact anita
      #organization berkman
    end

    factory :im do
      title 'Internet Monitor'
      description 'Monitor and score Internet access, control, and community in the countries of the world'
      repository_url nil
      app_url nil
      micropost_url 'https://twitter.com/thenetmonitor'
      news_url 'http://blogs.law.harvard.edu/internetmonitor/'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/internet-monitor/wiki'
      progress 55
      launch_date '2013-11-01'
      conception_date '2012-01-01'
      tag_list [['web', 'html5', 'research', 'world', 'datavis']]
      #contact ryan
      #organization berkman
    end

    factory :eda do
      title 'Emily Dickinson Archive'
      description "Gather all high resolution scans and transcriptions of of Emily Dickinson's writing into one place"
      repository_url nil
      app_url 'http://eda.dev.berkmancenter.org/'
      micropost_url ''
      news_url 'https://cyber.law.harvard.edu/projectmanagement/projects/eda/activity'
      documentation_url 'https://cyber.law.harvard.edu/projectmanagement/projects/eda/wiki'
      progress 65
      launch_date '2013-11-01'
      conception_date '2012-01-01'
      tag_list [['web', 'html5', 'research', 'literature', 'poetry', 'imaging']]
      #contact jen
      #organization berkman
    end

    factory :nil_contact do
      title 'nil_contact'
      tag_list [['test']]
      #contact nil
      #organization berkman
    end
  end
end
