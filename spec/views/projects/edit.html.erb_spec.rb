require 'spec_helper'

describe 'projects/edit' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  context ( 'basic input test' ) {
    before do
      # Previous title couldn't be found, switched to 'Hei'
      # (Make sure the project 'Hei' exists before running
      # the test
      assign( :project, Project.find_by_title( 'Hei' ) )
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

      should have_selector 'label', text: I18n.t( 'project_form_micropost_url' )
      should have_selector 'input[name="project[micropost_url]"]'

      should have_selector 'label', text: I18n.t( 'project_form_tag_list' )
      should have_selector 'input[name="project[tag_list]"]'

      should have_selector 'label', text: I18n.t( 'project_form_email' )
      should have_selector 'input[name="project[email]"]'

      should have_selector 'label', text: I18n.t( 'project_form_contact' )
      should have_selector 'select[name="project[contact_id]"]'

      should have_selector 'label', text: I18n.t( 'project_form_repository_url' )
      should have_selector 'input[name="project[repository_url]"]'

      should have_selector 'label', text: I18n.t( 'project_form_news_url' )
      should have_selector 'input[name="project[news_url]"]'

      should have_selector 'label', text: I18n.t( 'project_form_documentation_url' )
      should have_selector 'input[name="project[documentation_url]"]'
    end

    it ( 'should have action buttons' ) {
      should have_selector 'a', text: I18n.t( 'projects_form_cancel' )
      should have_selector "input[type='submit'][value='#{I18n.t( 'projects_form_submit' )}']"
    }
  }

end
