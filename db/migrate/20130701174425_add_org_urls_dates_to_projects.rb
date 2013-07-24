class AddOrgUrlsDatesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :app_url, :string
    add_column :projects, :micropost_url, :string
    add_column :projects, :organization, :string
    add_column :projects, :launch_date, :date
    add_column :projects, :conception_date, :date
  end
end
