FactoryGirl.define do
  factory :organization do
    factory :berkman do
      name 'Berkman Center for Internet and Society'
      url 'http://cyber.law.harvard.edu'
      location '23 Everett St, Cambridge, MA 02138'
      phone '617-495-7547'
    end

    factory :librarylab do
      name 'Harvard Library Innovation Lab'
      url 'http://librarylab.law.harvard.edu/about.html'
    end

    factory :o_nil_optionals do
      name 'o_nil_optionals'
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
      email 'rwestphal@cyber.law.harvard.edu'
      #contact ryan
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
      description 'no contact'
      tag_list [['test']]
      #contact nil
      #organization berkman
    end

    factory :nil_description do
      title 'nil_description'
      tag_list [['test']]
      #contact ryan
      #organization berkman
    end

    factory :long_description do
      title 'long_description'
      tag_list [['test','description']]
      description 'Bacon ipsum dolor sit amet sausage occaecat shankle flank. Eiusmod ball tip nulla, esse duis bacon turducken salami. Corned beef irure labore, t-bone drumstick ea ham hock. T-bone brisket laborum proident, jowl ea tri-tip aute excepteur commodo salami. Fatback sausage flank pariatur drumstick tenderloin veniam velit culpa tri-tip enim. Magna ham commodo incididunt veniam. Velit meatball sunt exercitation filet mignon. Leberkas chicken sirloin aliqua ut pastrami in, aliquip andouille do. Anim pariatur tenderloin tail brisket. Pork ullamco andouille sausage commodo sirloin aute est cupidatat brisket doner anim drumstick meatball eiusmod. Aute commodo ribeye fugiat, sirloin occaecat eiusmod deserunt pancetta nulla rump. Aliquip exercitation fugiat fatback turkey shank dolore minim. Shoulder spare ribs bacon pork. Meatball veniam qui jerky fugiat cupidatat, consectetur laborum eiusmod proident ribeye aliqua ground round shoulder chuck. Ullamco enim filet mignon andouille ad voluptate fugiat shoulder ut velit strip steak et. Mollit sunt dolore, swine est sed pork.'
      #contact ryan
      #organization berkman
    end

    factory :pappl_ryan do
      title 'Ryan Westphal'
      role 'Web Developer'
      email 'rwestphal@cyber.law.harvard.edu'
      description 'I am a web developer at Berkman, project lead for jQuery Geo, and wannabe indie game developer'
      app_url 'http://trippingthebits.com'
      micropost_url 'https://twitter.com/ryanttb'
      #organization berkman
      tag_list [['html', 'javascript', 'css', 'ruby', 'mapping', 'video games']]
    end
  end
end
