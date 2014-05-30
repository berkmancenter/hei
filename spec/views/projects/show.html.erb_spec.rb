require 'spec_helper'

describe 'projects/show' do
  subject { rendered }

  context ( 'with all the things' ) {
    let ( :p ) { Project.find_by_title 'Hei' }

    before {
      assign( :project, p )
      render
    }

    it { should have_css 'h1', text: p.title }

    it { should have_css 'p', text: p.description }

    it {
      should have_css 'a.organization', text: p.organization.name
      should have_css "a.organization[href*='#{organization_path p.organization}']"
    }

    it {
      should have_css 'a.app-url', text: "Launch #{p.title}"
    }

    it {
      should have_css '.facet-list ul'
      should have_css '.facet-list li', count: p.tags.count
    }

    it {
      tag = p.tags.first
      should have_css ".facet-list li a[href*='#{search_path}?tag[]=#{tag.name}']"
    }
  }

  context ( 'without app_url' ) {
    let ( :p ) { Project.find_by_title 'nil_app_url' }

    before {
      assign( :project, p )
      render
    }

    it { should_not have_css 'a.app-url' }
  }
end

