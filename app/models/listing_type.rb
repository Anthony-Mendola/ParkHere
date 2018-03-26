class ListingType < ApplicationRecord
  belongs_to :listing
  belongs_to :type

validates_presence_of :length

end
