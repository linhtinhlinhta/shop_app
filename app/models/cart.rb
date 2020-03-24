class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def add_product(product_id)
    current_item = order_items.find_by_product_id(product_id)
    current_item = if current_item
                     current_item.quantity += 1
                   else
                     current_item = order_items.build(:product_id => product_id)
                   end
    current_item
  end

  def subtotal
    order_items.to_a.sum { |item| item.total_price }
  end

end
