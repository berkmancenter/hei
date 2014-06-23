require 'spec_helper'

describe ( 'project_card_link_item partial' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  context ( 'record with most things' ) {
    let ( :p ) { Project.find_by_title 'Hei' }
    
    before {
      render partial: 'projects/project_card_link_item', object: p
    }

    it 'should be a project-card list item' do
      should have_selector 'li.project-card'
    end
    
    it 'should have project id' do
      should have_selector "li.project-card[data-project-id='#{p.id}']"
    end

    it 'should be a link to the project' do
      # the whole card is the link
      should have_selector "li.project-card>a[href*='#{project_path( p )}']"
    end

    it 'should have a header' do
      should have_selector 'h3', text: p.title
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

    it 'should show tags' do
      should have_css '.tags li', count: 3
    end
  }
}
