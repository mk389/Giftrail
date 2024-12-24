class Post < ApplicationRecord
  belongs_to :user  # userとの関連を設定

  validates :title, presence: true
  validates :production_area, presence: true
  mount_uploaders :images, ImageUploader
  ransack_alias :prefecture_eq, :prefecture

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body", "created_at", "updated_at", "production_area"]  # production_areaを検索対象に追加
  end

  # ransackable_associationsを定義（必要に応じて追加）
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def change
    add_column :posts, :production_area, :string
  end
  
  # titleとbodyを結合して検索するransackerの定義
  ransacker :title_or_description_cont do
    Arel.sql("CONCAT(title, ' ', body)")
  end
end