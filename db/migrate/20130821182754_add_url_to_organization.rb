class AddUrlToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :url, :string, limit: 1.kilobyte
  end
end
