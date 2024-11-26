class Post < ApplicationRecord
  belongs_to :user  # userとの関連を設定

# バリデーション（必要に応じて追加）
  validates :title, presence: true
  validates :production_area, presence: true
  mount_uploaders :images, ImageUploader
end