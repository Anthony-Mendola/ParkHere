class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cost
end
