class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cost
  has_many :reviews
  belongs_to :categories
end
