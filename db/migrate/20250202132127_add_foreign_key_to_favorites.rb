class AddForeignKeyToFavorites < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :posts
  end
end
