module Api
  module V1
    class ProductsController < ApplicationController
      def index
        products = Product.all
        render json: { status: 'SUCCESS', message: 'Loaded products',
                       products: products }, status: :ok
      end

      def show
        validate_product_id

        product = Product.find(params[:product_id])

        render json: { status: 'SUCCESS', message: 'Loaded product',
                       product: product }, status: :ok
      end

      def in_stock
        products = Product.where('inventory_count > ?', 0)
        render json: { status: 'SUCCESS', message: 'Loaded products',
                       products: products }, status: :ok
      end
    end
  end
end
