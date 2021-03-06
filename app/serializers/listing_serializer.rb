class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cost, :contact, :image,:address, :review_list, :longitude, :latitude
  has_one :user
  has_one :categories
  has_one :listing_types

  def review_list
    object.reviews.map do |review|
      {
        id: review.id,
        user: {
          id: review.user_id,
          name: User.find(review.user_id).email
        },
        content: review.content
      }
    end
  end

end
