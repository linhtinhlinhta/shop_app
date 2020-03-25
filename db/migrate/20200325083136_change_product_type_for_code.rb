class ChangeProductTypeForCode < ActiveRecord::Migration[5.1]
  def change
    change_column(:products, :code, :string)
  end
end
