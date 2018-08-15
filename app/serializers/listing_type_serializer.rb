class ListingTypesSerializer < ActiveModel::Serializer
  attributes :id, :length
  belongs_to :listings
  belongs_to :types
end
