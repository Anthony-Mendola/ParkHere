class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] { authorize_user!(@listing) }

  def index
#  @listings = Listing.recent.search(params[:search])
  @listings = Listing.all.sort_by(&:reviews_count).reverse
  end

  def show
    @review = Review.new
    @reviews = @listing.most_recent_reviews
  end

  def new
    @listing = Listing.new
    #@types = Type.all
    type = @listing.types.build
    type.listing_types.build
    @categories = Category.all
    @new_category = @listing.categories.build
  end

  def create
    #listing_params["length"] = listing_params["types_attributes"]["0"]["listing_types_attributes"]["0"]["length"].to_i
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      flash[:notice] = 'Successfully created listing'
      redirect_to @listing #redirects to listing show page
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
    @new_category = @listing.categories.build
    #@types = Type.all
    type = @listing.types.build
    type.listing_types.build
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to root_path, notice: "Successfully deleted that listing"
  end

  private
#Strong parameters are required so that users can't set additional keys and values on the url. We require
#the parameter key :listing and the attributes we will permit to be set.
    def listing_params
      params.require(:listing).permit(
        :title,
        :category,
        :description,
        :contact,
        :cost,
        :image,
        :address,
        :longitude,
        :latitude,
        :types_attributes => [ :id, :name, :listing_types_attributes => [:length]],
        type_ids: [],
        category_ids: [],
        categories_attributes: [:name]
        )

    end

    #In this line, our set_listing action is running a database query on the
    #Listing model that will return a listing with an ID that matches the route parameters.
    #It will store this record in the @listing instance variable and make it available to views.

    def set_listing
      @listing = Listing.find(params[:id])
    end
end
