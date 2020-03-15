class CartsController < ApplicationController
  def show
    @cart = current_user.cart
    @order_items = @cart.order_items
  end
  def destroy
    @cart = current_user.cart
    @cart.destroy
  end
end

