class Post < ApplicationRecord
# モデルの関連付け
  belongs_to :user  # userとの関連を設定

# バリデーション（必要に応じて追加）
  validates :title, presence: true
  validates :prefecture, presence: true
end