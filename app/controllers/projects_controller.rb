class ProjectsController < ApplicationController

  def index
    @primary_facets = Facet.primary

    @projects = Project.includes( :taggings, :tags ).order( 'updated_at desc' ).paginate( page: params[ :page ], per_page: 256 )

    @tags = ActsAsTaggableOn::Tag.joins( :taggings ).uniq.order( :name )

    render layout: !request.xhr?
  end

  def search
    @search = Project.search do
      fulltext params[ :q ]


      qtags = params[ :tag ]

      facet :tag_list

      # tags, AND'd
      if qtags.present?
        all_of do
          qtags.each do |tag|
            with( :tag_list, tag )
          end
        end
      end
    end

    @hits = @search.hits
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    unless Hei::Application.config.hei[ 'allow_new_projects' ]
      redirect_to projects_path and return 
    end
    @project = Project.new

    if Hei::Application.config.hei[ 'force_twitter' ]
      @project.micropost_url = 'https://twitter.com/'
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def edit
    @project = Project.find(params[:id])

    if Hei::Application.config.hei[ 'force_twitter' ] && !@project.micropost_url.present?
      @project.micropost_url = 'https://twitter.com/'
    end
  end

  def create
    unless Hei::Application.config.hei[ 'allow_new_projects' ]
      redirect_to projects_path and return 
    end
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
