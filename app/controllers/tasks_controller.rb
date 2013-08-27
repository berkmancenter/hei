class TasksController < ApplicationController
  def import
    if params[ :projects_csv ].present?
      Project.create_from_csv params[ :projects_csv ]
      flash.now[ :success ] = 'upload!'
    elsif request.post?
      flash.now[ :error ] = 'no file O_o'
    end
  end
end
