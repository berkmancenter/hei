require 'spec_helper'

describe ( 'tasks requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  context ( 'get /tasks/import' ) {
    before {
      visit tasks_import_path
    }

    it {
      should have_title 'Import Projects'
      should have_selector 'h1', text: 'Import Projects'
      should_not have_selector '.alert-message'
    }
  }

  context ( 'with import error flash' ) {
    before {
      visit tasks_import_path
      click_button 'Import'
    }

    it {
      should have_selector '.alert.alert-error'
    }
  }
}

