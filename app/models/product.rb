class Product < ApplicationRecord
  has_many :images
  belongs_to :category
  has_many :order_items
end

