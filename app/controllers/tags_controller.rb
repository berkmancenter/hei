class TagsController < ApplicationController

  def create
    if not params[:pid].nil?
      m = Project
    # else if not params[:cid].nil? m=Contact
    # for further implementation
    end
    obj = m.find(params[:pid])
    obj.tag_list.add(params[:tag][:name],parse: true)
    obj.save
    redirect_to(:back)
  end

  def destroy
    if not params[:pid].nil?
      m = Project
    # else if not params[:cid].nil? m=Contact
    # for further implementation
    end
    obj = m.find(params[:pid])
    obj.tag_list.remove(params[:id])
    obj.save
    redirect_to(:back)
  end


end
