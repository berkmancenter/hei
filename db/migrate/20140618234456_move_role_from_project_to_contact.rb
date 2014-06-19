class MoveRoleFromProjectToContact < ActiveRecord::Migration
  def up
		remove_column :projects, :role
		add_column :contacts, :role, :string
  end

  def down
		remove_column :contacts, :role
		add_column :projects, :role, :string
  end
end
