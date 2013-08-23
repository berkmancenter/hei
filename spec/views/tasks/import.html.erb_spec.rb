require 'spec_helper'

describe ( 'tasks/import' ) {
  let ( :config ) { Hei::Application.config.hei }

  subject { rendered }

  before {
    render
  }

  it {
    should have_selector 'h1', text: 'Import Projects'
  }

  it ( 'should have import form' ) {
    should have_selector "form[action*='#{tasks_import_path}'][method='post'][enctype='multipart/form-data']"

    should have_selector 'label', text: I18n.t( 'tasks_import_file_label' )
    should have_selector 'input[type="file"]'

    should have_selector 'input[type="submit"][value="Import"]'
  }
}
