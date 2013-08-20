require 'spec_helper'

describe 'projects/new' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  before do
    assign( :project, Project.new )
    render
  end

  it 'should have project inputs' do
    should have_selector 'label', text: I18n.t( 'project_form_title' )
    should have_selector 'input[name="project[title]"]'

    should have_selector 'label', text: I18n.t( 'project_form_organization' )
    should have_selector 'select[name="project[organization_id]"]'

    should have_selector 'label', text: I18n.t( 'project_form_description' )
    should have_selector 'input[name="project[description]"]'

    should have_selector 'label', text: I18n.t( 'project_form_app_url' )
    should have_selector 'input[name="project[app_url]"]'

    should have_selector 'label', text: I18n.t( 'project_form_tag_list' )
    should have_selector 'input[name="project[tag_list]"]'

    if config[ 'projects_as' ] == 'people'
      should have_selector 'label', text: I18n.t( 'project_form_email' )
      should have_selector 'input[name="project[email]"]'
    else
      should_not have_selector 'label', text: I18n.t( 'project_form_email' )
      should_not have_selector 'input[name="project[email]"]'
    end
  end
end
