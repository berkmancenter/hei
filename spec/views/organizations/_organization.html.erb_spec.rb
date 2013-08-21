require 'spec_helper'

describe ( 'organizations/_organization' ) {
  subject { rendered }

  context ( 'normal organization' ) {
    let ( :o ) { Organization.find_by_name 'Berkman Center for Internet and Society' }

    before {
      render o
    }

    it {
      should have_selector 'h1', text: o.name
      should have_selector 'div', text: o.location
      should have_selector 'div', text: o.phone
    }
  }
}


