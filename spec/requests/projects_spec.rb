require 'spec_helper'

describe ( 'projects requests' ) {
  subject { page }

  describe ( 'get /projects' ) {
    before { visit( projects_path ) }

    it {
      should( have_title( 'Hei, projects!' ) );
    }
  }

  describe ( 'get /projects/:id' ) {
    let( :project ) { Project.first }

    before { visit( project_path( project ) ) }

    it {
      should( have_title( "Hei, #{project.title}!" ) );
    }
  }
}
