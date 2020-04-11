class ProductsController < ApplicationController
  def index
    @products = @q.result(distinct:true).page(params[:page]).per params[:limit]
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_user.cart.order_items.new if current_user
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end
