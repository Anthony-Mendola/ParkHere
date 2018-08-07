class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] { authorize_user!(@review) }

  def index
    @listing = Listing.find_by(id: params[:listing_id])
    @reviews = @listing.reviews
    #render 'reviews/index', :layout => false
    #render :json => @reviews
  end

  def new
    @review = Review.new
  end

  def create
    listing = Listing.find_by(id: params[:listing_id])
    @review = listing.reviews.create(user_id: current_user.id, content: review_params[:content])
    

    if @review.save
      #flash[:notice] = "review added"
      render 'reviews/show', :layout => false
    else
      #flash[:alert] = "Cannot submit an empty review"
      render "listings/show"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "review updated"
      redirect_to @listing
    else
      flash[:alert] = "Cannot submit an empty review"
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to @listing
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def set_review
    @listing = Listing.find_by(id: params[:listing_id])
    @review = @listing.reviews.find_by(id: params[:id])
  end

end
