class Post < ApplicationRecord
  belongs_to :user  # userとの関連を設定
  has_one_attached :image  # 画像を添付する設定

# バリデーション（必要に応じて追加）
  validates :title, presence: true
  validates :prefecture, presence: true
end