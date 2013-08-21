require 'spec_helper'

describe 'organizations/index' do
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  let ( :os ) { Organization.all }

  before do
    assign( :organizations, os )
    render
  end

  it 'should have new organization link' do
    if config[ 'projects_as' ] == 'people'
      should_not have_selector "a[href*='#{new_organization_path}']", text: I18n.t( 'organizations_new' )
    else
      should have_selector "a[href*='#{new_organization_path}']", text: I18n.t( 'organizations_new' )
    end
  end

  it 'should have an organization card' do
    should have_selector 'li.organization-card'
  end
end
