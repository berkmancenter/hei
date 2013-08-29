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
      }

      it ( 'should return success alert' ) {
        post :import, projects_csv: @projects_csv
        flash[ :success ].should_not eq( nil )
      }

      it ( 'should import test record' ) {
        post :import, projects_csv: @projects_csv
        p = Project.find_by_title( 'csv import' )
        p.should_not eq( nil )
        p.organization.should_not eq( nil )
        p.role.should eq( 'Hei Importer' )
        p.description.should eq( 'I am an import from an RSVP CSV file.' )
        p.email.should eq( 'import.other@cyber.law.harvard.edu' )
        p.micropost_url.should eq( 'https://twitter.com/heimporter' )
        p.app_url.should eq( 'http://hei.dev.berkmancenter.org' )
        p.tags.count.should eq( 2 )
      }
    }

    context ( 'with double import' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_duplicate.csv' );
      }

      it ( 'should not make two duplicate records' ) {
        expect {
          post :import, projects_csv: @projects_csv
        }.to_not change( Project, :count )
      }
    }

    context ( 'with Yes in email other field' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_yes_email.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should use primary email' ) {
        p = Project.find_by_title( 'csv import_yes_email' )
        p.organization.should_not eq( nil )
        p.email.should eq( 'import.yes.email@cyber.law.harvard.edu' )
      }
    }

    context ( 'with No in email other field' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_no_email.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should leave email nil' ) {
        p = Project.find_by_title( 'csv import_no_email' )
        p.organization.should_not eq( nil )
        p.email.should eq( nil )
      }
    }

    context ( 'with empty in email other field' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_empty_email.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should leave email nil' ) {
        p = Project.find_by_title( 'csv import_empty_email' )
        p.organization.should_not eq( nil )
        p.email.should eq( nil )
      }
    }

    context ( 'with no http in app_url' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_no_http.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should have app_url' ) {
        p = Project.find_by_title( 'csv import_no_http' )
        p.organization.should_not eq( nil )
        p.app_url.should eq( 'http://hei.dev.berkmancenter.org' )
      }
    }

    context ( 'with only title' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_only_title.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should have mostly blanks' ) {
        p = Project.find_by_title( 'csv import_only_title' )
        p.should_not eq( nil )
        p.organization.should eq( nil )
        p.role.should eq( nil )
        p.description.should eq( nil )
        p.email.should eq( nil )
        p.micropost_url.should eq( nil )
        p.app_url.should eq( nil )
        p.tags.count.should eq( 0 )
      }
    }

    context ( 'with double import' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_no_list.csv' );
      }

      it ( 'should not make two duplicate records' ) {
        expect {
          post :import, projects_csv: @projects_csv
        }.to_not change( Project, :count )
      }
    }

    context ( 'with different case title' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_different_case.csv' );
      }

      it ( 'should ignore case' ) {
        expect {
          post :import, projects_csv: @projects_csv
        }.to_not change( Project, :count )
      }
    }

    context ( 'also with different case title' ) {
      before {
        @projects_csv = fixture_file_upload( '/files/people_different_case.csv' );
        post :import, projects_csv: @projects_csv
      }

      it ( 'should update original with new case' ) {
        p_old = Project.find_by_title( 'Ryan Westphal' )
        p_new = Project.find_by_title( 'ryan westphal' )

        p_old.should eq( nil )
        p_new.should_not eq( nil )
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


