class Category < ApplicationRecord
  has_many :listing_categories
  has_many :listings, through: :listing_categories
  validates :name, uniqueness: true
end
