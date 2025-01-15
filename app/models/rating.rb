class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  validates :rating_value, presence: true, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5 }
end