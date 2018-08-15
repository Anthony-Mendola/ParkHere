class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cost, :contact, :image,:address, :review_list, :longitude, :latitude
  has_one :user
  has_many :reviews

  def review_list
    object.reviews.map do |review|
      {
        id: review.id,
        user: {
          id: review.user_id,
          name: User.find(review.user_id).name
        },
        content: review.content
      }
    end
  end

end
