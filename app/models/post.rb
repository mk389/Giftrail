class Post < ApplicationRecord
  belongs_to :user  # userとの関連を設定
  has_many_attached :images

# バリデーション（必要に応じて追加）
  validates :title, presence: true
  validates :prefecture, presence: true
end