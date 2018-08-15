class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :listings
  belongs_to :listing_categories
end
