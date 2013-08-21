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
      should have_selector 'a.url', text: o.url
      should have_selector 'div.location', text: o.location
      should have_selector 'div.phone', text: o.phone
    }
  }

  context ( 'allowed nils' ) {
    let ( :o ) { Organization.find_by_name 'o_nil_optionals' }

    before {
      render o
    }

    it {
      should have_selector 'h1', text: o.name
      should_not have_selector 'a.url'
      should_not have_selector 'div.location'
      should_not have_selector 'div.phone'
    }
  }
}


