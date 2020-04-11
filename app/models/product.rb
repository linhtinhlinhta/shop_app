class Product < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :category
  has_many :order_items
  validates :code, presence: true
  accepts_nested_attributes_for :images, allow_destroy: true,
                                reject_if: proc { |att| att['image_url'].blank? }

end
