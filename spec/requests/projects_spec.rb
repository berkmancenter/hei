require 'spec_helper'

describe 'projects requests' do
  subject { page }

  describe 'get /projects' do
    before do
      visit projects_path
    end

    it {
      should have_title 'Hei projects!'
    }

    it {
      should have_selector "a[href*='#{new_project_path}']"
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
        expect { click_button 'Create Project' }.not_to change( Project, :count )
      }
    end

    describe 'submit with title' do
      before {
        fill_in 'Title', with: 'Submit with title'
      }

      it ( 'should create a project' ) {
        expect {
          click_button 'Create Project'
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

      it ( "should show all the project's tags" ) {
        should have_css '.facet_header', count: project.tags.count
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

    it ( 'should have an update form & submit button' ) {
      should have_selector "form[method='post'][action*='#{project_path( project )}'] input[type='submit']"
    }

    it ( 'should have some form inputs' ) {
      should have_selector 'select[name="project[organization_id]"]'
      should have_selector 'select[name="project[contact_id]"]'
      should have_selector 'input[type="text"][name="project[title]"]'
      should have_selector 'input[type="text"][name="project[description]"]'
      should have_selector 'input[type="url"][name="project[repository_url]"]'
      should have_selector 'input[type="url"][name="project[app_url]"]'
      should have_selector 'input[type="url"][name="project[micropost_url]"]'
      should have_selector 'input[type="url"][name="project[news_url]"]'
      should have_selector 'input[type="url"][name="project[documentation_url]"]'

      # dates?
      
      should have_selector 'input[type="text"][name="project[tag_list]"]'
    }
  end

end
