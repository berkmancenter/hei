require 'spec_helper'

describe 'Project model' do
  describe 'with valid data' do
    it {
      project_valid = Project.new( FactoryGirl.attributes_for( :project_valid ) );
      project_valid.should be_valid;
    }
  end

end
