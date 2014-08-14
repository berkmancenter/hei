class RemoveEmailFromUsers < ActiveRecord::Migration
  # actually, only removes the fact that it can't be nil
  def up
    change_column :users, :email, :string, :null => true
  end

  def down
    change_column :users, :email, :string, :null => false
  end
end
