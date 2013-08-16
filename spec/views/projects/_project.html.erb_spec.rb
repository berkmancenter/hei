require 'spec_helper'

describe 'project partial' do
  subject { rendered }
  let ( :project ) { Project.find_by_title 'Hei' }

  before {
    render partial: 'projects/project', object: project
  }

  it 'should be a project-card list item' do
    should have_selector 'li.project-card'
  end

  it 'should be a link to the project' do
    # the whole card is the link
    should have_selector "li.project-card>a[href*='#{project_path( project )}']"
  end

  it 'should have a header' do
    should have_selector 'h3', text: project.title
  end

  it 'should show updated_at' do
    should have_selector 'time', text: project.updated_at.to_formatted_s( :short )
    should have_css "time[datetime='#{project.updated_at.to_s( :db ).sub( ' ', 'T' )[ 0..-4 ]}']"
  end

  it 'should show organization' do
    should have_selector 'div', text: project.organization.name
  end

  it 'should show progress' do
    should have_selector 'progress'
    should have_css "progress[value='#{project.progress}']"
  end

  it 'should show tags' do
    should have_css '.tags li', count: 3
  end
end
