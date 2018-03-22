class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] { authorize_user!(@listing) }

  def index
  @listings = Listing.search(params[:search])
  end

  def show
    @review = Review.new
  #  @reviews = @review.most_recent_reviews
  end

  def new
    @listing = Listing.new
    @categories = Category.all
    @listing.types.build
    @new_category = @listing.categories.build
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      flash[:notice] = 'Successfully created listing'
      redirect_to @listing
    else
      @listing.types.build
      render :new
    end
  end

  def edit
    @categories = Category.all
    @new_category = @listing.categories.build
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
        types_attributes: [:id, :name, :_destroy],
        category_ids: [],
        categories_attributes: [:name]
        )

    end

    def set_listing
      @listing = Listing.find(params[:id])
    end
end
