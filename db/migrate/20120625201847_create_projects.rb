class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :null => false, :limit => 255
      t.string :description, :limit => 5.kilobytes
      t.timestamps
    end
  end
end
