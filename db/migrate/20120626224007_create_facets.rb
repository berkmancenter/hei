class CreateFacets < ActiveRecord::Migration
  def change
    create_table :facets do |t|
      t.string :name, :null => false, :limit => 255
      t.string :context, :null => false, :limit => 128
      t.integer :position, :default => 1
      t.boolean :primary, :default => false

      t.timestamps
    end
  end
end
