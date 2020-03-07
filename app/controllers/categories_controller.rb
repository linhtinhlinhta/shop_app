class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.all.page(params[:page]).per(9)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
