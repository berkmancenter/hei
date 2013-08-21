require 'spec_helper'

describe 'projects requests' do
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe 'get /projects' do
    before do
      visit projects_path
    end

    it {
      should have_title "Hei #{I18n.t 'projects'}!"
    }

    it ( 'should have some project cards' ) {
      should have_css 'li.project-card', count: Project.count
    }

    context 'click project card' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        click_link project.title
      end

      it 'should show project view' do
        should have_title project.title
      end
    end

    context 'with updated project' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        # save so its updated_at is heigher than others
        # to make it first in the list
        project.description = 'updated'
        project.save

        visit projects_path
      end

      it ( 'should have most recently updated first' ) {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    end

    context 'with missing description' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        project.description = nil
        project.save #force it to first page

        visit projects_path
      end

      it ( 'should still render' ) {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    end

    context 'with missing description' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        project.description = nil
        project.save #force it to first page

        visit projects_path
      end

      it ( 'should still render' ) {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    end

    it ( 'should have a search form' ) {
      should have_selector "form[method='get'][action*='#{search_path}']"
    }

    describe 'basic search' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        fill_in 'q', with: project.title
      end

      it ( 'should only show Hei project card' ) {
        click_button 'Search'
        should have_css 'li.project-card', count: 1
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    end

    describe 'search with facet as q' do
      before do
        fill_in 'q', with: 'test' # there is at least one project with the tag: test
      end

      it ( 'should show at least one project card' ) {
        click_button 'Search'
        should have_selector 'li.project-card'
      }
    end
  end

  describe 'get /search' do
    context 'with title search' do
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
    end

    context 'with result having no description' do
      let ( :project ) { Project.find_by_title 'nil_description' }

      before do
        visit( search_path + "?q=#{project.title}" )
      end

      it  {
        should have_selector "li[data-project-id=\"#{project.id}\"]:first-child"
      }
    end
  end

  describe 'get /projects/new' do
    before { visit new_project_path }

    it {
      should have_title 'Hei New Project!'
    }

    it ( 'should have an insert form & submit button' ) {
      should have_selector "form[method='post'][action*='#{projects_path}'] input[type='submit']"
    }

    describe 'submit invalid' do
      it ( 'should not create a project' ) {
        expect { click_button I18n.t( 'projects_form_submit' ) }.not_to change( Project, :count )
      }
    end

    describe 'submit with title' do
      before {
        fill_in I18n.t( 'project_form_title' ), with: 'Submit with title'
      }

      it ( 'should create a project' ) {
        expect {
          click_button I18n.t( 'projects_form_submit' )
        }.to change( Project, :count ).by( 1 )
      }
    end
  end

  describe 'get /projects/:id' do
    context 'normal project' do
      let ( :project ) { Project.find_by_title 'Hei' }

      before do
        visit project_path( project )
      end

      it {
        should have_title "Hei #{project.title}!"
      }

      it ( 'should have tag links' ) {
        should have_selector '.facet-list ul'
        should have_selector '.facet-list ul li a'
      }

      context ( 'click tag link' ) {
        before {
          click_link 'html5'
        }

        it ( 'should have moved to search' ) {
          should have_selector '.search-facets a', text: 'html5'
        }
      }

      it ( 'should have an edit link' ) {
        should have_selector "a[href*='#{edit_project_path( project )}']"
      }

    end

    context 'project w/o contact' do
      let ( :project ) { Project.find_by_title 'nil_contact' }

      before do
        visit project_path( project )
      end

      it {
        should have_title "Hei #{project.title}!"
      }
    end

    context 'project w/o description' do
      let ( :project ) { Project.find_by_title 'nil_description' }

      before do
        visit project_path( project )
      end

      it {
        should have_title "Hei #{project.title}!"
      }
    end
  end

  describe 'get /projects/:id/edit' do
    let ( :project ) { Project.first }

    before { visit edit_project_path( project ) }

    it {
      should have_title "Hei #{project.title}!"
    }

    it ( 'should have an update form' ) {
      should have_selector "form[method='post'][action*='#{project_path( project )}']"
    }
  end

end
