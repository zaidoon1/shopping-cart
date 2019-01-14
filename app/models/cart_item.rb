class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product_id, presence: true
  validates :cart_id, presence: true
  validates :item_quantity, presence: true, numericality: { greater_than: 0 }

  def total
    product.price * item_quantity
  end
end
