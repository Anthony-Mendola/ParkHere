class Listing < ApplicationRecord
    belongs_to :user

    geocoded_by :address
    after_validation :geocode

    has_many :types, dependent: :destroy

    has_many :reviews, dependent: :destroy
    has_many :reviewers, through: :reviews, source: :user

    has_many :listing_categories, dependent: :destroy
    has_many :categories, through: :listing_categories

    validates :title, :description, :cost, :contact, :image, presence: true
    validates :title, length: { in: 1..90 }
    validates :description, length: { minimum: 10 }

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"  }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    def categories_attributes=(category_attributes)
      category_attributes.values.each do |category_attribute|
        if !category_attribute['name'].blank?
          category = Category.find_or_create_by(category_attribute)
          self.categories << category
        end
      end
    end

    def self.most_recently_updated
      order('updated_at DESC')
    end

    def self.search(search)
        if search
            search = search.downcase
            where("lower(title) LIKE ?", "%#{search}%")
        else
          all
        end
      end
    end
    #def most_recent_reviews
    #  reviews.limit(3)
  #  end
