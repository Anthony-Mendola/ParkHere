class TypeSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :listings
end
