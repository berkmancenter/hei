require 'spec_helper'

describe 'projects requests' do
  subject { page }

  describe 'get /projects' do
    before { visit projects_path }

    it {
      should have_title 'Hei projects!'
    }

    it {
      should have_selector "a[href*='#{new_project_path}']"
    }
  end

  describe 'get /projects/new' do
    before { visit new_project_path }

    it {
      should have_title 'Hei New Project!'
    }

    it ( 'should have an insert form & submit button' ) {
      should have_selector "form[method='post'][action*='#{projects_path}'] input[type='submit']"
    }

    describe 'submit invalid' do
      it ( 'should not create a project' ) {
        expect { click_button 'Create Project' }.not_to change( Project, :count )
      }
    end

    describe 'submit with title' do
      before {
        fill_in 'Title', with: 'Submit with title'
      }

      it ( 'should create a project' ) {
        expect {
          click_button 'Create Project'
        }.to change( Project, :count ).by( 1 )
      }
    end
  end

  describe 'get /projects/:id' do
    let ( :project ) { Project.first }

    before { visit project_path( project ) }

    it {
      should have_title "Hei #{project.title}!"
    }

    it ( "should show all the project's tags" ) {
      should have_css '.facet_header', count: project.tags.count
    }

    it ( 'should have an edit link' ) {
      should have_selector "a[href*='#{edit_project_path( project )}']"
    }
  end

  describe 'get project w/o contact' do
    let ( :project ) { Project.find_by_title 'nil_contact' }

    before { visit project_path( project ) }

    it {
      should have_title "Hei #{project.title}!"
    }
  end

  describe 'get /projects/:id/edit' do
    let ( :project ) { Project.first }

    before { visit edit_project_path( project ) }

    it {
      should have_title "Hei #{project.title}!"
    }

    it ( 'should have an update form & submit button' ) {
      should have_selector "form[method='post'][action*='#{project_path( project )}'] input[type='submit']"
    }
  end
end
