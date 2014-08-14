require 'spec_helper'

describe User do
  describe 'with valid data' do
    let ( :u ) { User.new FactoryGirl.attributes_for( :huid ) }

    it ( 'should be valid' ) {
      u.should be_valid
    }

    it ( 'should respond to correct attributes' ) {
      u.should respond_to :username
    }
  end
end
