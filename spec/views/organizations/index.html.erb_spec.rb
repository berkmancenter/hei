require 'spec_helper'

describe 'organizations/index' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  let ( :os ) { Organization.where( name: 'Berkman Center for Internet and Society' ) }

  before do
    assign( :organizations, os )
    render
  end

  it 'should have new organization link' do
    should have_selector "a[href*='#{new_organization_path}']", text: I18n.t( 'add_organization' )
  end

  it 'should have an organization' do
    should have_selector 'section.organization.partial'
  end
end
