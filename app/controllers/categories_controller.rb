class CategoriesController < ApplicationController
before_action :authenticate_user!


  def index
    @category = Category.new
    @categories = Category.all
  end

  def show
    @listings = ListingCategory.listings_by_category(params[:id])
    render :'listings/index', :layout => false
end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def create
    new_category = Category.new(category_params)
    if new_category.save
      flash[:notice] = "#{new_category.name} successfully saved!"
    else
      flash[:error] = "Category has already been taken, try a different name."
    end
    redirect_to categories_path
  end



  private

  def category_params
    params.require(:category).permit(:name)
  end

end
