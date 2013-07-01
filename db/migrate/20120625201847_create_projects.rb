class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :null => false, :limit => 255
      t.string :description, :limit => 5.kilobytes
      t.string :repository_url, :limit => 1.kilobyte
      t.string :app_url, :limit => 1.kilobyte
      t.string :micropost_url, :limit => 1.kilobyte
      t.string :news_url, :limit => 1.kilobyte
      t.string :documentation_url, :limit => 1.kilobyte
      t.string :organization, :limit => 1.kilobyte
      t.date :launch_date
      t.date :conception_date
      t.timestamps
    end
  end
end
