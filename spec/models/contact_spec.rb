require 'spec_helper'

describe Contact do
  describe 'with valid data' do
    it ( 'should be valid' ) {
      c = Contact.new( FactoryGirl.attributes_for( :ryan ) );
      c.should be_valid;
    }

    it ( 'should respond to correct attributes' ) {
      c = Contact.new( FactoryGirl.attributes_for( :ryan ) );
      c.should respond_to( :first_name );
      c.should respond_to( :last_name );
      c.should respond_to( :email );
      c.should respond_to( :organizations );
    }
  end
end
