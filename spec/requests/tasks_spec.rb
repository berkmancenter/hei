require 'spec_helper'

describe ( 'tasks requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe ( 'get /tasks/import' ) {
    before do
      visit( tasks_import_path )
    end

    it {
      should have_title 'Import Projects'
      should have_selector 'h1', text: 'Import Projects'
    }
  }

  describe ( 'post /tasks/import' ) {
    context ( 'with posting valid csv file' ) {
      before {
        @file = fixture_file_upload( 'spec/fixtures/files/people.csv' );
      }

      it ( 'should import projects from a csv' ) {
        post tasks_import_path, projects_csv: @file
        should have_title 'Import Projects'
        #response.should be_success
      }
    }
  }
}

