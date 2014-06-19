require 'spec_helper'

describe 'contacts/show' do
  subject { rendered }

  context ( 'with all the things' ) {
    let ( :c ) { Contact.find_by_first_name 'Ryan' }

    before {
      assign( :contact, c )
      render
    }

    it {
      should have_css 'h1', text: "#{c.first_name} #{c.last_name}"
    }

    it {
      should have_css '.role'
    }

#    it {
#      should have_selector 'div.role'
#    }
  }
end


