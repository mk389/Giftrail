class AddPrefectureToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :prefecture, :string
  end
end