require 'swagger_helper'

describe 'Cart Items API' do
  path '/api/v1/carts/{:cart_id}/cart_items/{:product_id}' do
    put 'Updates the quantity for an item in a cart' do
      tags 'Cart_Items'
      produces 'application/json'
      parameter name: :cart_id, in: :path, type: :string
      parameter name: :product_id, in: :path, type: :string
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          item_quantity: { type: :integer }
        },
        required: :item_quantity
      }

      response '200', 'Item quantity updated.' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

        let(:product_id) { 'Cart item updated' }
        run_test!
      end

      response '404', 'Cart or product not found.' do
        let(:product_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/carts/{:cart_id}/cart_items/{:product_id}' do
    patch 'Updates the quantity for an item in a cart' do
      tags 'Cart_Items'
      produces 'application/json'
      parameter name: :cart_id, in: :path, type: :string
      parameter name: :product_id, in: :path, type: :string
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          item_quantity: { type: :integer }
        },
        required: :item_quantity
      }

      response '200', 'Item quantity updated.' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

        let(:product_id) { 'Cart item updated' }
        run_test!
      end

      response '404', 'Cart or product not found' do
        let(:product_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/carts/{:cart_id}/cart_items/{:product_id}' do
    delete 'Removes an item from a cart' do
      tags 'Cart_Items'
      produces 'application/json'
      parameter name: :cart_id, in: :path, type: :string
      parameter name: :product_id, in: :path, type: :string

      response '200', 'Item quantity updated.' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

        let(:product_id) { 'cart item updated' }
        run_test!
      end

      response '404', 'Cart or product not found' do
        let(:product_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/carts/{:cart_id}/cart_items' do
    post 'Adds an item to a cart' do
      tags 'Cart_Items'
      description 'Adds an item to a cart. If the item already exists in'\
      ' the cart then the new quantity for the item is added to'\
      ' the old quantity stored'
      produces 'application/json'
      parameter name: :cart_id, in: :path, type: :string
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer },
          item_quantity: { type: :integer }
        },
        required: %w[product_id item_quantity]
      }

      response '200', 'Item added' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

        let(:product_id) { 'cart item' }
        run_test!
      end

      response '404', 'Cart or product not found' do
        let(:cart_id) { 'invalid' }
        run_test!
      end
    end
  end
end
