class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      validates :title, presence: true, length: { maximum: 255 }
      validates :prefecture, presence: true
      validates :body, presence: true, length: { maximum: 65_535 }
      validates :image, presence: true
      t.timestamps
    end
  end
end
