class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true
  after_destroy :cleanup_empty_tags

  private

  def cleanup_empty_tags
    Tag.where.not(id: posts.select(:id)).destroy_all
  end
end
