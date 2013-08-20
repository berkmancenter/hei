require 'spec_helper'

describe 'projects/search' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  let( :s ) {
    Project.search do
      fulltext 'Hei'
      facet :tag_list
    end
  }

  before do
    assign( :search, s )
    assign( :hits, s.hits )

    render template: 'projects/search', layout: 'layouts/application'
  end

  it 'should have the main nav' do
    should have_selector '.navbar .nav'
    should have_selector ".nav li a[href*='#{projects_path}']", text: I18n.t( 'nav_projects' )
    should have_selector ".nav li a[href*='#{organizations_path}']", text: I18n.t( 'nav_organizations' )

    if config[ 'projects_as' ] == 'people'
      should_not have_selector ".nav li a[href*='#{contacts_path}']", text: I18n.t( 'nav_contacts' )
    else
      should have_selector ".nav li a[href*='#{contacts_path}']", text: I18n.t( 'nav_contacts' )
    end
  end

  it 'should not have the main header and byline' do
    should have_css 'h1', text: 'Hei Search', visible: false
  end

  it 'should have new project link' do
    should have_selector "a[href*='#{new_project_path}']", text: I18n.t( 'add_project' )
  end

  it 'should have a project card' do
    should have_selector 'li.project-card'
  end
end
