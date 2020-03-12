class Product < ApplicationRecord
  has_many :images
  belongs_to :category
end

