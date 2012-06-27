class ProjectsController < ApplicationController

  def index
    @projects = Project.order('created_at desc').paginate(:page => params[:page])
    render :layout => ! request.xhr?
  end

  def show
  end

end
