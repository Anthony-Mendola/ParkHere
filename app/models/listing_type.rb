class ListingType < ApplicationRecord
  belongs_to :listing
  belongs_to :type

validates :length, numericality: true

#def self.listings_by_type(type_id)
#listing_types = ListingType.where(type_id: type_id)
#listing_type.collect {|listing_type| listing_type.listing}
#end

end
