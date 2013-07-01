require 'spec_helper'

describe 'Organization model' do
  describe 'with valid data' do
    it ( 'should be valid' ) {
      o = Organization.new( FactoryGirl.attributes_for( :berkman ) );
      o.should be_valid;
    }

    it ( 'should respond to correct attributes' ) {
      o = Organization.new( FactoryGirl.attributes_for( :berkman ) );
      o.should respond_to( :name );
      o.should respond_to( :location );
      o.should respond_to( :phone );
    }
  end

end
