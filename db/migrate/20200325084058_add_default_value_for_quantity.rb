class AddDefaultValueForQuantity < ActiveRecord::Migration[5.1]
  def change
    change_column_default :order_items, :quantity, 1
  end
end
