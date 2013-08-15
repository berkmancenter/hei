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

  it 'should have project id in link' do
    should have_selector "li.project-card>a[data-project-id='#{project.id}']"
  end

  it 'should have a header' do
    should have_selector 'h3', text: project.title
  end
end
