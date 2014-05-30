require 'spec_helper'

describe ( 'tasks requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe ( 'get /tasks/import' ) {
    before {
      visit tasks_import_path
    }

    it {
      should have_title 'Import Projects'
      should have_selector 'h1', text: 'Import Projects'
      should_not have_selector '.alert-message'
    }

    context ( 'with import error flash' ) {
      before {
        visit tasks_import_path
        click_button 'Import'
      }

      it {
        should have_selector '.alert.alert-error'
      }
    }
  }


  describe ( 'post /tasks/import' ) {
    context ( 'with valid csv' ) {
      before {
        @projects_csv = fixture_file_upload( Rails.root.join('spec/fixtures/files/contact.csv') );
      }

      it {
        pending 'all upload tests are currently disabled'
        post tasks_import_path, projects_csv: @projects_csv
        expect( response ).to be_success
      }

      it ( 'should create a project' ) {
        pending 'all upload tests are currently disabled'
        expect { post tasks_import_path, projects_csv: @projects_csv }.to change( Project, :count ) 
      }
    }

    describe ( 'search' ) {
      before {
        @projects_csv = fixture_file_upload( Rails.root.join('spec/fixtures/files/contact.csv') );
        #post tasks_import_path, projects_csv: @projects_csv
      }

      it ( 'should appear in search results' ) {
        pending 'all upload tests are currently disabled'
        visit( search_path + "?tag[]=import" )
        expect( response ).to be_success
      }

    }
  }
}

