class ProjectsController < ApplicationController

  def index
    @primary_facets = Facet.primary
    @projects = Project.includes(:taggings,:tags).order('created_at desc').paginate(:page => params[:page])
    render :layout => ! request.xhr?
  end

  def show
    @project = Project.includes(:taggings, :tags).find(params[:id])
  end

end
