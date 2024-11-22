class RenamePrefectureColumns < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :prefecture, :residence
    rename_column :posts, :prefecture, :production_area
  end
end
