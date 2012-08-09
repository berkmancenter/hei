class ProjectsController < ApplicationController

  def index
    @primary_facets = Facet.primary
    @projects = Project.includes(:taggings,:tags).order('created_at desc').paginate(:page => params[:page])
    render :layout => ! request.xhr?
  end

  def show
    facet_hash
    @project = Project.includes(:taggings, :tags).find(params[:id])
  end

  def facet_hash
    @facet_hash = Facet.facet_hash
  end

end
