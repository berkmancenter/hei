require 'spec_helper'

describe ( TasksController ) {
  let ( :config ) { Hei::Application.config.hei }

  describe ( 'POST import' ) {
    context ( 'with valid csv file' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people.csv' );
      }

      it ( 'should import projects from a csv' ) {
        post :import, projects_csv: @projects_csv
        response.should be_success
      }
    }
  }
}


