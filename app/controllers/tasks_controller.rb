require 'csv'

class TasksController < ApplicationController
  def import
    if params[ :projects_csv ].present?
      projects_csv = params[ :projects_csv ].read

      CSV.parse( projects_csv, { headers: true } ) { | row |
        Project.update_or_create_from_csv_row( row ) unless row[ 'We are curating a dynamic public list.  Would you like to be included?' ] == 'No'
      }

      Project.reindex
      Sunspot.commit

      flash.now[ :success ] = 'upload!'
    elsif request.post?
      flash.now[ :error ] = 'no file O_o'
    end
  end
end
