require 'spec_helper'

describe ( 'organizations/show' ) {
  subject { rendered }

  context ( 'normal organization' ) {
    let ( :o ) { Organization.find_by_name 'Berkman Center for Internet and Society' }

    before {
      assign( :organization, o )
      assign( :projects, Project.where( organization_id: o.id ) )
      render
    }

    it ( 'should have project cards' ) {
      should have_selector 'li.project-card'
    }
  }
}

