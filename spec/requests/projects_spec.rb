require 'spec_helper'

describe ( 'projects requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe ( 'get /projects' ) {
    before do
      visit projects_path
    end

    it {
      should have_title "Hei #{I18n.t 'projects'}!"
    }

    it ( 'should have some project cards' ) {
      should have_css 'li.project-card', count: Project.count
    }

    it ( 'should list all tags' ) {
      should have_selector '.facet-list ul'
      should have_selector '.facet-list ul li a'
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
      # move this to view spec
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

    context ( 'with a tag soon to not be in use' ) {
      it {
        should have_selector '.facet-list li a', text: 'unusedtag'
      }
    }

    context ( 'with a tag no longer in use' ) {
      let ( :project ) { Project.find_by_title( 'unused_tag' ) }

      before {
        visit edit_project_path( project )
        fill_in 'project[tag_list]', with: ''
        click_button I18n.t( 'projects_form_submit' )
        visit projects_path
      }

      it {
        should_not have_selector '.facet-list li a', text: 'unusedtag'
      }
    }
  }

  describe 'get /projects/new' do
    before { visit new_project_path }

    it {
      should have_title 'Hei New Project!'
    }

    it ( 'should have an insert form & submit button' ) {
      should have_selector "form[method='post'][action*='#{projects_path}'] input[type='submit']"
    }

    it ( 'should supply twitter prefix' ) {
      if config[ 'projects_as' ] == 'people'
        should have_selector 'input[name="project[micropost_url]"][value="https://twitter.com/"]'
      end
    }

    describe 'submit invalid' do
      it ( 'should not create a project' ) {
        expect { click_button I18n.t( 'projects_form_submit' ) }.not_to change( Project, :count )
      }
    end

    describe 'submit with title' do
      before {
        fill_in 'project[title]', with: 'Submit with title'
      }

      it ( 'should create a project' ) {
        expect {
          click_button I18n.t( 'projects_form_submit' )
        }.to change( Project, :count ).by( 1 )
      }
    end

    context ( 'submit w/o changing provided twitter url' ) {
      before {
        fill_in 'project[title]', with: 'No Twitter'
      }

      it ( 'should create a project with empty micropost_url' ) {
        if config[ 'projects_as' ] == 'people'
          projects_count = Project.count
          click_button I18n.t( 'projects_form_submit' )
          expect( Project.count ).to eq( projects_count + 1 )
          expect( Project.last.micropost_url ).to eq( nil )
        end
      }
    }

    describe 'submit with non-twitter micropost_url' do
      before {
        fill_in 'project[title]', with: 'Twitter username'
        fill_in 'project[micropost_url]', with: 'http://cyber.law.harvard.edu'
      }

      it ( 'should create a project' ) {
        if config[ 'projects_as' ] == 'people'
          expect {
            click_button I18n.t( 'projects_form_submit' )
          }.to_not change( Project, :count )
        end
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

  describe ( 'get /projects/:id/edit' ) {
    context ( 'basic edit' ) {
      let ( :project ) { Project.first }

      before { visit edit_project_path( project ) }

      it {
        should have_title "Hei #{project.title}!"
      }

      it ( 'should have an update form' ) {
        should have_selector "form[method='post'][action*='#{project_path( project )}']"
      }
    }

    context ( 'with missing micropost_url' ) {
      let ( :project ) { Project.find_by_title( 'nil_description' ) }

      before { visit edit_project_path( project ) }

      it ( 'should supply twitter prefix' ) {
        if config[ 'projects_as' ] == 'people'
          should have_selector 'input[name="project[micropost_url]"][value="https://twitter.com/"]'
        end
      }

      context ( 'with saving w/o changing micropost_url' ) {
        before {
          fill_in 'project[description]', with: 'update'
        }

        it ( 'should allow saving edits' ) {
          if config[ 'projects_as' ] == 'people'
            expect { click_button I18n.t( 'projects_form_submit' ) }.to change{ Project.find( project.id ).updated_at }
          end
        }
      }
    }
  }
}
