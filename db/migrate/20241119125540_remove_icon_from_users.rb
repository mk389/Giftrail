class RemoveIconFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :icon, :string
  end
end
