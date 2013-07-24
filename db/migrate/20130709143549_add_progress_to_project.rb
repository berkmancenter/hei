class AddProgressToProject < ActiveRecord::Migration
  def change
    add_column :projects, :progress, :integer
  end
end
