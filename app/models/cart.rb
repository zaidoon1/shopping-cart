class Cart < ApplicationRecord
  has_many :cart_items, dependent: :delete_all

  # Attempts to checkout, if all the items are in stock
  # then the product inventory is decreased for each item and the cart
  # is cleared
  #
  def checkout
    if items_in_stock && cart_has_items
      purchase_products
      clear_cart
      return true
    end
    false
  end

  # Attempts to add an item to a cart. If the product doesn't exist
  # or the item quantity provided is invalid then an error is raised
  def add_product(product_id, item_quantity)
    item_quantity = item_quantity.to_i
    if cart_has_item(product_id)
      # Attempting to add an item that already exists in the cart.
      # The new quantity for the item is summed with the current item quantity
      current_item_quantity = item_quantity(product_id)
      update_cart_item(product_id, current_item_quantity + item_quantity)
    else
      # Attempting to add new item to cart
      validate_item_in_stock(product_id, item_quantity)

      cart_items.create!(product_id: product_id, item_quantity: item_quantity)
    end
  end

  # Attempts to update the quantity of an item in the cart.
  # If the item doesn't exist or the item quantity is invalid
  # then an error is raised
  def update_cart_item(product_id, item_quantity)
    item_quantity = item_quantity.to_i
    validate_item_in_stock(product_id, item_quantity)
    validate_cart_item(product_id)

    cart_item = cart_items.find_by!(product_id: product_id.to_i)
    cart_item.update!(item_quantity: item_quantity)
  end

  # Calculates the subtotal for all the items in the cart
  def calculate_subtotal
    cart_items.to_a.sum(&:total)
  end

  private

  def purchase_products
    cart_items.find_each do |item|
      item.product.update(
        inventory_count: item.product.inventory_count - item.item_quantity
      )
    end
  end

  def clear_cart
    cart_items.delete_all
  end

  # Ensures the item quantity is not greater than the
  # number of products available in stock.
  # If the product does not exist then an error is raised.
  def validate_item_in_stock(product_id, item_quantity)
    product = Product.find(product_id)
    product_inventory = product.inventory_count

    unless product_inventory >= item_quantity
      raise ArgumentError, 'Item quantity can not be greater'\
        ' than product inventory.'
    end
  end

  # Ensures that the item exists in the cart
  def validate_cart_item(product_id)
    cart_item = cart_items.find_by(product_id: product_id)
    raise ArgumentError, 'The item does not exist in the cart' if cart_item.nil?
  end

  # Returns a boolean indicating whether an item already exists
  # in the cart or not. If the product doesn't exist then an error is raised
  def cart_has_item(product_id)
    !cart_items.find_by(product_id: product_id.to_i).nil?
  end

  def item_quantity(product_id)
    cart_item = cart_items.find_by!(product_id: product_id.to_i)
    cart_item.item_quantity
  end

  def cart_has_items
    cart_items.any?
  end

  # Returns a boolean indicating whether all the items in the cart
  # are in stock or not
  def items_in_stock
    cart_items.none? { |item| item.item_quantity > item.product.inventory_count }
  end
end
