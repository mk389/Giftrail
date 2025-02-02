class ChangeFavoritesUserIdAndPostIdToBigint < ActiveRecord::Migration[7.2]
  def change
    change_column :favorites, :user_id, :bigint
    change_column :favorites, :post_id, :bigint
  end
end
