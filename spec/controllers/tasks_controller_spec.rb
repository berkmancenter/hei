require 'spec_helper'

describe ( TasksController ) {
  let ( :config ) { Hei::Application.config.hei }

  describe ( 'POST import' ) {
    context ( 'with valid csv file' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people.csv' );
      }

      it ( 'should import projects from a csv' ) {
        expect { post :import, projects_csv: @projects_csv }.to change( Project, :count )
        #response.should be_success
      }

      it ( 'should return success alert' ) {
        post :import, projects_csv: @projects_csv
        flash[ :success ].should_not eq( nil )
      }
    }

    context ( 'with no csv file' ) {
      it ( 'should return error alert' ) {
        post :import
        flash[ :error ].should_not eq( nil )
      }
    }

  }
}


