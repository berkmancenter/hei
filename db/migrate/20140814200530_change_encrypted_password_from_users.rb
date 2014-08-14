class ChangeEncryptedPasswordFromUsers < ActiveRecord::Migration
  # just remove the old devise database columns
  def up
		remove_column :users, :encrypted_password
  end

  def down
		add_column :users, :encrypted_password, :string, :null => true
  end
end
