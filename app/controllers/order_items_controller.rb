class OrderItemsController < ApplicationController
  def create
    @cart = current_user.cart
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    @cart.save
  end

  def update
    @cart = current_user.cart
    @order_item = @cart.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @cart.order_items
  end

  def destroy
    @cart = current_user.cart
    @order_item = @cart.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @cart.order_items
  end

  private
  def order_item_params
    params.require(:order_item).permit(:product_id, :cart_id, :quantity)
  end

end
