class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.all.page(params[:page]).per(CATEGORY_PAGINATES_PER)
    if current_user
      @order_item = current_user.cart.order_items.new
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end


