require 'spec_helper'

describe ( 'projects requests' ) {
  subject { page }

  describe ( 'get /projects' ) {
    before { visit( projects_path ) }

    it {
      should have_title 'Hei projects!'
    }

    it {
      should have_selector "a[href*='#{new_project_path}']"
    }
  }

  describe ( 'get /projects/new' ) {
    before { visit( new_project_path ) }

    it {
      should have_title 'Hei New Project!'
    }

    it ( 'should have an insert form & submit button' ) {
      should have_selector "form[method='post'][action*='#{projects_path}'] input[type='submit']"
    }

    describe ( 'submit invalid' ) {
      it ( 'should not create a project' ) {
        expect { click_button 'Create Project' }.not_to change( Project, :count )
      }
    }

    describe ( 'submit with title' ) {
      before {
        fill_in 'Title', { with: 'Submit with title' }
      }

      it ( 'should create a project' ) {
        expect {
          click_button 'Create Project'
        }.to change( Project, :count ).by( 1 )
      }
    }
  }

  describe ( 'get /projects/:id' ) {
    let ( :project ) { Project.first }

    before { visit( project_path( project ) ) }

    it {
      should( have_title( "Hei #{project.title}!" ) );
    }

    it ( "should show all the project's tags" ) {
      should have_css '.facet_header', { count: project.tags.count }
    }

    it ( 'should have an edit link' ) {
      should have_selector "a[href*='#{edit_project_path( project )}']"
    }
  }

  describe ( 'get project w/o contact' ) {
    let ( :project ) { Project.find_by_title( 'nil_contact' ) }

    before { visit( project_path( project ) ) }

    it {
      should( have_title( "Hei #{project.title}!" ) );
    }
  }

  describe ( 'get /projects/:id/edit' ) {
    let ( :project ) { Project.first }

    before { visit( edit_project_path( project ) ) }

    it {
      should have_title "Hei #{project.title}!"
    }

    it ( 'should have an update form & submit button' ) {
      should have_selector "form[method='post'][action*='#{project_path( project )}'] input[type='submit']"
    }
  }
}
