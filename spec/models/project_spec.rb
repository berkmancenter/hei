require 'spec_helper'

describe ( 'Project model' ) {
  let ( :config ) { Hei::Application.config.hei }

  context ( 'with valid data' ) {
    it ( 'should be valid' ) {
      p = Project.new( FactoryGirl.attributes_for( :hei ) );
      p.should be_valid;
    }

    it ( 'should respond to correct attributes' ) {
      p = Project.new( FactoryGirl.attributes_for( :hei ) );
      p.should respond_to( :title );
      p.should respond_to( :description );
      p.should respond_to( :repository_url );
      p.should respond_to( :app_url );
      p.should respond_to( :documentation_url );
      p.should respond_to( :news_url );
      p.should respond_to( :micropost_url );
      p.should respond_to( :contact );
      p.should respond_to( :launch_date );
      p.should respond_to( :conception_date );
      p.should respond_to( :progress );
      p.should respond_to( :organization );

      p.should respond_to( :email );
      p.should respond_to( :role );
    }
  }
}
