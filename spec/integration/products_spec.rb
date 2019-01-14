require 'swagger_helper'

describe 'Products API' do
  path '/api/v1/products/{product_id}' do
    get 'Retrieves a product' do
      tags 'Products'
      produces 'application/json'
      parameter name: :product_id, in: :path, type: :string

      response '200', 'Product information' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 product: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     title: { type: :string },
                     price: { type: :number },
                     inventory_count: { type: :integer },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   }
                 }
               },
               required: :product_id

        let(:product_id) { Product.find(1).id }
        run_test!
      end

      response '404', 'Product not found' do
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

  path '/api/v1/products/' do
    get 'Retrieves all products' do
      tags 'Products'
      produces 'application/json'

      response '200', 'A list of products' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 products: {
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
               }

        let(:product_id) { Product.find(1).id }
        run_test!
      end
    end
  end

  path '/api/v1/products/in_stock' do
    get 'Retrieves all products in stock' do
      tags 'Products'
      produces 'application/json'

      response '200', 'A list of products in stock' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 products: {
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
               }

        let(:product_id) { Product.find(1).id }
        run_test!
      end
    end
  end
end
