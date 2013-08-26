require 'spec_helper'

describe 'projects/index' do
  # todo: move the layout tests to a different spec
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  let ( :ps ) { Project.where( title: 'Hei' ).includes( :taggings, :tags ).paginate( page: params[ :page ] ) }

  before do
    assign( :projects, ps )
    assign( :tags, ActsAsTaggableOn::Tag.order( 'name' ) )
    render template: 'projects/index', layout: 'layouts/application'
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

  it 'should have the main header and byline' do
    should have_selector 'h1', text: "Hei #{I18n.t 'byline'}"

    if config[ 'projects_as' ] == 'people'
      should have_selector 'div.subtext'
    end
  end

  it 'should have new project link' do
    if config[ 'projects_as' ] == 'people'
      # removed per request
      should_not have_selector "a[href*='#{new_project_path}']"
    else
      should have_selector "a[href*='#{new_project_path}']", text: I18n.t( 'add_project' )
    end
  end

  it ( 'should have all tags' ) {
    should have_selector '.facet-list'
    should have_css '.facet-list li', count: ActsAsTaggableOn::Tag.count
  }

  it ( 'should have tag links' ) {
    # definitely a tag with name = test
    should have_selector ".facet-list li a[href*='#{search_path}?tag[]=test']"
  }

  it 'should have a project card' do
    should have_selector 'li.project-card'
  end
end
