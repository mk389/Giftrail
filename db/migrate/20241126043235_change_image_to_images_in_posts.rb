class ChangeImageToImagesInPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :image, :string
    add_column :posts, :images, :text, array: true, default: []
  end
end
