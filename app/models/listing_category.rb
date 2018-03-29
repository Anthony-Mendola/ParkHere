class ListingCategory < ApplicationRecord
  belongs_to :listing
  belongs_to :category


  def self.listings_by_category(category_id)
    listing_categories = ListingCategory.where(category_id: category_id)
    listing_categories.collect {|listing_category| listing_category.listing}
  end


end
