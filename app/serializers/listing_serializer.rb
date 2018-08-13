class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cost
  has_many :reviews
  has_many :listing_categories
end
