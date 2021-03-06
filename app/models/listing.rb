class Listing < ApplicationRecord
    belongs_to :user

    geocoded_by :address
    after_validation :geocode

    has_many :listing_types
    has_many :types, through: :listing_types


    has_many :reviews, dependent: :destroy
    has_many :reviewers, through: :reviews, source: :user

    has_many :listing_categories, dependent: :destroy


    has_many :categories, through: :listing_categories

    validates :title, :description, :cost, :contact, :image, presence: true
    validates :title, length: { in: 1..90 }
    validates :description, length: { minimum: 10 }

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"  }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    #scope :by_category, -> (category_ids) { joins(:listing_categories).where(listing_categories: {category_id: category_ids}).distinct }

    scope :recent, -> {order("listings.updated_at DESC")}

   #accepts_nested_attributes_for :types

    def types_attributes=(types_attributes)
      #raise types_attributes.values.inspect
      types_attributes.values.each do |types_attribute|
        if !types_attribute["name"].empty?
        #  binding.pry
          type = Type.find_or_create_by(name: types_attribute["name"])
        #  self.types << type
        #    binding.pry
        self.listing_types.build(type: type, length: types_attribute["listing_types_attributes"]["0"]["length"])
        #  self.listing_types.last.update(length: types_attribute["listing_types_attributes"]["0"]["length"])

          #self.listing_types.build(type: type, length: types_attribute["listing_types_attributes"]["id"]["length"])
        end
     end
    end


    def categories_attributes=(category_attributes)
      category_attributes.values.each do |category_attribute|
        if !category_attribute['name'].blank?
          category = Category.find_or_create_by(category_attribute)
          self.categories << category
        end
      end
    end

  #  def self.most_recently_updated
  #    order('updated_at DESC')
  #  end

    def self.search(search)
        if search
           search = search.downcase
            where("lower(title) LIKE ?", "%#{search}%")
        else
          all
        end
      end

      def most_recent_reviews
        reviews.limit(3)
      end

      def reviews_count
        reviews.count
      end

#def most_reviews
    #  Review.all(:select => 'listings.*, count(reviews.id) as review_count',
    #  :joins => reviews.id,
    #  :group => "listings.reviews.id"
  #    :order => 'review_count')
#end

def next
 
  if next_list = self.class.where("id > ?", id).first
    next_list
  else
    Listing.first
  end
end

def previous
 
  if previous_list = self.class.where("id < ?", id).last
    previous_list
  else
    Listing.last
  end
end



  end
