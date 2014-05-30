require 'spec_helper'

describe ( 'layouts/application' ) {
  subject { rendered }

  before {
    render
  }

  describe ( 'top nav' ) {
    it { should have_css 'div.navbar' }

    it { should have_css '.navbar ul.nav' }

    it {
      should have_css '.nav li', count: 4
    }

    it {
      should have_selector ".nav li a[href*='#{projects_path}']", text: I18n.t( 'nav_projects' )
      should have_selector ".nav li a[href*='#{organizations_path}']", text: I18n.t( 'nav_organizations' )
      should have_selector ".nav li a[href*='#{contacts_path}']", text: I18n.t( 'nav_contacts' )
    }
  }
}
