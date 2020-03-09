class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(8)
  end

  def show
    @q = Product.ransack(params[:q])
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end
