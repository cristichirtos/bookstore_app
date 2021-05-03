class AddNameToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :name, :integer
  end
end
