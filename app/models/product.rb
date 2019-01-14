class Product < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
  validates :inventory_count, presence: true,
                              numericality: { greater_than_or_equal_to: 0 }
end
