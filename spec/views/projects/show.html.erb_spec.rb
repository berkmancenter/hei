require 'spec_helper'

describe 'projects/show' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  context 'record with most things' do
    let ( :p ) { Project.find_by_title 'Hei' }

    before {
      assign( :project, p )
      render
    }

    it {
      should have_selector 'h1', text: p.title
    }
  end

  context 'pappl with all the things' do
    let ( :p ) { Project.find_by_title 'Ryan Westphal' }

    before {
      assign( :project, p )
      render
    }

    it {
      should have_selector 'h1', text: p.title

      should have_selector 'p', text: p.description

      should have_selector "a.organization[href*='#{organization_path p.organization}']", text: p.organization.name

      if config[ 'projects_as' ] == 'people'
        should have_selector 'div.role', text: p.role

        should have_selector 'a', text: p.email
        should have_css "a[href='mailto:#{p.email}']"

        should have_css "a[href='#{p.micropost_url}']"
        should have_selector 'a', text: p.app_url
        should have_css "a[href='#{p.app_url}']"
      else
        should_not have_selector 'div.role'
      end
    }

    it {
      should have_selector '.facet-list ul'
      should have_css '.facet-list li', count: p.tags.count

      tag = p.tags.first
      should have_selector ".facet-list li a[href*='#{search_path}?tag[]=#{tag.name}']"
    }
  end

  context ( 'pappl with missing micropost_url but having app_url' ) {
    let ( :p ) { Project.find_by_title 'Emily Dickinson Archive' }

    before {
      assign( :project, p )
      render
    }

    it {
      should_not have_selector 'dt', text: I18n.t( 'projects_show_micropost_url' )

      should have_selector 'dt', text: I18n.t( 'projects_show_app_url' )
      should have_selector 'dd', text: p.app_url
    }


  }

#  context 'record missing app_url' do
#    it 'should not show a launch link' do
#      should_not have_selector 
#    end
#  end
end


