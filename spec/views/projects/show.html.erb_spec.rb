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

      if config[ 'projects_as' ] == 'people'
        should have_selector "a.organization[href*='#{organization_path p.organization}']", text: p.organization.name
        should have_selector 'a', text: p.email
        should have_css "a[href='mailto:#{p.email}']"
        should have_css "a[href='#{p.micropost_url}']"
        should have_selector 'a', text: p.app_url
        should have_css "a[href='#{p.app_url}']"
      end
    }
  end

#  context 'record missing app_url' do
#    it 'should not show a launch link' do
#      should_not have_selector 
#    end
#  end
end


