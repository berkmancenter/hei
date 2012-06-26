class ProjectsController < ApplicationController
  def index
    @projects = Project.order('created_at desc').paginate(:page => params[:page])
  end
end
