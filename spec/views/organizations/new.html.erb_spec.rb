require 'spec_helper'

describe ( 'organizations/new' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  before {
    assign( :organization, Organization.new )
    render
  }

  it ( 'should have organizations inputs' ) {
    should have_selector 'label', text: I18n.t( 'organization_form_name' )
    should have_selector 'input[name="organization[name]"]'

    should have_selector 'label', text: I18n.t( 'organization_form_location' )
    should have_selector 'input[name="organization[location]"]'

    should have_selector 'label', text: I18n.t( 'organization_form_url' )
    should have_selector 'input[name="organization[url]"]'

    should have_selector 'label', text: I18n.t( 'organization_form_phone' )
    should have_selector 'input[name="organization[phone]"][type="tel"]'

    if config[ 'allow_new_orgs' ]
      should have_selector 'label', text: I18n.t( 'organization_form_contacts' )
      should have_selector 'input[name="organization[contact_ids][]"][type="hidden"]'
    else
      should_not have_selector 'label', text: I18n.t( 'organization_form_contacts' )
      should_not have_selector 'input[name="organization[contact_ids][]"]'
    end
  }

  it ( 'should have action buttons' ) {
    should have_selector 'a', text: I18n.t( 'organizations_form_cancel' )
    should have_selector "input[type='submit'][value='#{I18n.t( 'organizations_form_submit' )}']"
  }
}

