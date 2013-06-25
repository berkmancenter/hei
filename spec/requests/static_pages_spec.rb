require 'spec_helper'

describe 'static pages requests' do
  subject { page }

  describe 'get /about' do
    before { visit about_url }

    it { 
      should have_title ( 'About Hei' );
    }
  end
end

