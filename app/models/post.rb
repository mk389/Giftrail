class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :ratings, dependent: :destroy

  before_save :extract_tags

  validates :title, presence: true, length: { maximum: 33 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :production_area, presence: true
  validates :images, presence: true

  mount_uploaders :images, ImageUploader
  ransack_alias :prefecture_eq, :prefecture

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body", "created_at", "updated_at", "production_area"]  # production_areaを検索対象に追加
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def change
    add_column :posts, :production_area, :string
  end
  
  # titleとbodyを結合して検索する
  ransacker :title_or_description_cont do
    Arel.sql("CONCAT(title, ' ', body)")
  end

  def save_tags(savearticle_tags)
    savearticle_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(name: new_name)
      self.tags << article_tag
    end
  end

  def average_rating
    ratings.average(:rating_value).to_f
  end

  private

  def extract_tags
    if self.body.present?
      tags = self.body.scan(/#\w+/).uniq  # #付きの文字を抽出
      tags.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name.delete('#'))
        self.tags << tag unless self.tags.include?(tag)
      end
    end
  end
end