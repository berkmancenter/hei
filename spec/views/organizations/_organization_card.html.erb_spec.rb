require 'spec_helper'

describe ( 'organizations/_organization_card' ) {
  subject { rendered }

  context ( 'normal organization' ) {
    let ( :o ) { Organization.find_by_name 'Berkman Center for Internet and Society' }

    before {
      render partial: 'organizations/organization_card', locals: { organization: o }
    }

    it {
      should have_selector 'li.organization-card'
      should have_selector 'li.organization-card a'
      should have_selector 'li.organization-card a section.organization.partial'
    }
  }
}


