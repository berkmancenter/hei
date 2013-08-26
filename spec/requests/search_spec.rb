require 'spec_helper'

describe ( 'search requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe ( 'get /search' ) {
    context ( 'with title search' ) {
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        visit( search_path + "?q=#{project.title}" )
      end

      it {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }

      it 'should have facet lists' do
        should have_selector '.search-facets ul'
        should have_css '.search-facets li', count: 3 # Hei has three tags, therefore three facets to choose
        should have_css '.search-facets li .ballot.checked', count: 0 # none of them are checked
      end

      context 'with a click of a tag' do
        it 'should move the tag from off to on' do
          click_link 'html5'
          should have_css '.search-facets li .ballot.checked', count: 1
        end
      end
    }

    context ( 'with result having no description' ) {
      let ( :project ) { Project.find_by_title 'nil_description' }

      before do
        visit( search_path + "?q=#{project.title}" )
      end

      it  {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    }
  }
}
