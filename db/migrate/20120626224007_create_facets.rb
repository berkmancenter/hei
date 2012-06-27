class CreateFacets < ActiveRecord::Migration
  def change
    create_table :facets do |t|
      t.string :name
      t.string :context
      t.integer :position

      t.timestamps
    end
  end
end
