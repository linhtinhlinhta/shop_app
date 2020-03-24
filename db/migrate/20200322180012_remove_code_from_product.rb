class RemoveCodeFromProduct < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :code, :integer
  end
end
