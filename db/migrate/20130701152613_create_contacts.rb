class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.timestamps
    end
    
    [:first_name, :last_name, :phone, :email].each do|col|
      add_index :contacts, col
    end
    
    create_table(:contacts_organizations, :id => false) do|t|
      t.references :contact
      t.references :organization
    end
  end
end
