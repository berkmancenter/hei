require 'csv'

class TasksController < ApplicationController
  def import
    if params[ :projects_csv ].present?
      projects_csv = params[ :projects_csv ].read

      CSV.parse( projects_csv, { headers: true } ) { | row |
        p = Project.update_or_create_from_csv_row( row )
      }


      flash.now[ :success ] = 'upload!'
    elsif request.post?
      flash.now[ :error ] = 'no file O_o'
    end
  end
end
