module Api
  module V1
    class CartsController < ApplicationController
      # GET    /api/v1/carts/:cart_id
      def show
        validate_cart_id

        cart = Cart.find(params[:cart_id])

        render json: { status: 'SUCCESS', message: 'Loaded cart content',
                       cart_content: cart.cart_items,
                       subtotal: cart.calculate_subtotal }, status: :ok
      end

      # POST   /api/v1/carts/checkout
      # body ex:
      # {
      #   "cart_id": 1
      # }
      def checkout
        validate_cart_id

        cart = Cart.find(params[:cart_id])
        checkout_successful = cart.checkout

        unless checkout_successful
          raise ActionController::BadRequest, 'Checkout could not be'\
           ' completed. Some products might be out of stock or the'\
           ' cart is empty.'
        end

        render json: { status: 'SUCCESS', message: 'Checkout successful.' },
               status: :ok
      end

      # POST   /api/v1/carts
      def create
        cart = Cart.create!
        render json: { status: 'SUCCESS',
                       message: 'Cart created.', cart: cart }, status: :created
      end
    end
  end
end
