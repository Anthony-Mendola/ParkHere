class Type < ApplicationRecord
  has_many :listing_types
  has_many :listings, through: :listing_types
  validates :name, presence: true
end
