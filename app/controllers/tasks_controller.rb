require 'csv'

class TasksController < ApplicationController
  def import
    if params[ :projects_csv ].present?
      projects_csv = params[ :projects_csv ].read

      CSV.parse( projects_csv ) { | row |
        p = Project.new_from_csv_row( row )
        p.save
      }


      flash.now[ :success ] = 'upload!'
    elsif request.post?
      flash.now[ :error ] = 'no file O_o'
    end
  end
end
