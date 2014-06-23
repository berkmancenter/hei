require 'spec_helper'

describe ( 'project partial' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  context ( 'record with most things' ) {
    let ( :p ) { Project.find_by_title 'Hei' }
    
    before {
      render p
    }


    it 'should have a header' do
      should have_selector 'h1', text: p.title
    end

    it 'should show updated_at' do
      should have_selector 'time', text: p.updated_at.to_formatted_s( :short )
      should have_css "time[datetime='#{p.updated_at.to_s( :db ).sub( ' ', 'T' )[ 0..-4 ]}']"
    end

    it 'should show organization' do
      should have_selector 'div', text: p.organization.name
    end

    it 'should show progress' do
      if p.progress.present?
        should have_selector 'div.progress'
        should have_selector 'div.bar'
      else
        should_not have_selector 'div.progress'
        should_not have_selector 'div.bar'
      end
    end

  }
}
