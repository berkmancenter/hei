require 'spec_helper'

describe 'project show' do
  subject { rendered }

  context 'record with most things' do
    let ( :p ) { Project.find_by_title 'Hei' }

    before {
      assign( :project, p )
      render template: 'projects/show'
    }

    it {
      should have_selector 'h1', text: 'Hei'
    }

  end

#  context 'record missing app_url' do
#    it 'should not show a launch link' do
#      should_not have_selector 
#    end
#  end
end


