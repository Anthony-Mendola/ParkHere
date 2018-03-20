class Listing < ApplicationRecord
  belongs_to :user

  has_many :types, dependent: :destroy

    has_many :reviews, dependent: :destroy
    has_many :reviewers, through: :reviews, source: :user

    has_many :listing_categories, dependent: :destroy
    has_many :categories, through: :listing_categories

    validates :title, :description, :cost, :contact, :image, presence: true
    validates :title, length: { in: 1..90 }

    has_attached_file :image, styles: { medium: "300x300#", large: "500x500#"  }, default_url: "/images/:style/missing.png"
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

    def most_recent_reviews
      comments.limit(5)
    end

  end