class ListingType < ApplicationRecord
  belongs_to :listing
  belongs_to :type

  def name
    type.name
  end
end
