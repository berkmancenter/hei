class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :location
      t.string :phone
      t.timestamps
    end  
    
    [:name, :location, :phone].each do|col|
      add_index :organizations, col
    end
  end
end
