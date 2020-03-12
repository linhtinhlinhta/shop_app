class AddCodeToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :code, :integer
  end
end
