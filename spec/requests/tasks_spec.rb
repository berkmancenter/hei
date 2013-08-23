require 'spec_helper'

describe ( 'tasks requests' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { page }

  describe ( 'get /tasks/import' ) {
    before do
      visit( tasks_import_path )
    end

    it {
      should have_title 'Import Projects'
      should have_selector 'h1', text: 'Import Projects'
    }
  }
}

