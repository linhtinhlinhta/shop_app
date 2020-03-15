class OrderItemsController < ApplicationController
  before_action :set_order_item
  def index
    @order_items = OrderItem.all
  end
  def create
    @cart = current_user.cart
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    respond_to do |format|
      if @order_item.save
          format.html { redirect_to('/', :notice => 'Order item was successfully created') }
          format.js
          format.json { render :show, status: :created, location: @order_item }
      else
          format.html { render :new }
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @cart = current_user.cart
    @order_item = @cart.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @cart.order_items
  end

  private
  def order_item_params
    params.require(:order_item).permit(:product_id, :cart_id)
  end
  def set_order_item
    @order_item = OrderItem.find_by(params[:id])
  end
end

