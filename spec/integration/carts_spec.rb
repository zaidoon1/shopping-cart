require 'swagger_helper'

describe 'Carts API' do
  path '/api/v1/carts/{cart_id}' do
    get 'Retrieves all the items in a cart' do
      tags 'Carts'
      produces 'application/json'
      parameter name: :cart_id, in: :path, type: :string

      response '200', 'A list of items in the cart' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 cart_content: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       title: { type: :string },
                       price: { type: :number },
                       inventory_count: { type: :integer },
                       created_at: { type: :string },
                       updated_at: { type: :string }
                     }
                   }
                 }
               },
               required: :product_id

        let(:product_id) { Product.find(1).id }
        run_test!
      end

      response '404', 'cart not found' do
        let(:product_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/carts/' do
    post 'Creates a cart' do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Cart created' do
        let(:cart) { 'cart' }
        run_test!
      end

      response '422', 'Cart not created' do
        let(:product_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/carts/checkout' do
    post 'Attemps to checkout' do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'
      description 'Attempts to checkout. If all the items are in stock'\
      ' then the product inventory is decreased for each item and the'\
      ' cart is cleared. An error will be returned if an item is out'\
      ' of stock or if the cart is empty'
      parameter name: :checkout, in: :body, schema: {
        type: :object,
        properties: {
          cart_id: { type: :integer }
        },
        required: ['cart_id']
      }

      response '200', 'Checkout successful.' do
        let(:cart) { 'cart' }
        run_test!
      end

      response '400', 'Checkout not completed.' do
        let(:product_id) { 'invalid' }
        run_test!
      end

      response '404', 'Cart not found' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               },
               required: :product_id

        let(:product_id) { Product.find(1).id }
        run_test!
      end
    end
  end
end
