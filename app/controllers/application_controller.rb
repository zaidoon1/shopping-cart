class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :render_not_found_response
  rescue_from ActionController::BadRequest, with: :render_bad_request_response
  rescue_from ActionController::ParameterMissing,
              with: :render_bad_request_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_exception_response
  rescue_from ActiveRecord::RecordNotDestroyed,
              with: :render_record_exception_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::RoutingError, with: :render_not_found_response

  protected

  # Ensures that the product_id parameter exists in the request
  # and that the product_id exists in the Product table
  def validate_product_id
    params.require(:product_id)
    product_id = params[:product_id].to_i # prevents SQL injection
    unless Product.exists?(product_id)
      raise ArgumentError, 'Product not found. The product might'\
       ' not exist or has been deleted.'
    end
  end

  # Ensures that the cart_id parameter exists in the request
  # and that the cart_id exists in the Cart table
  def validate_cart_id
    params.require(:cart_id)
    cart_id = params[:cart_id].to_i # prevents SQL injection
    raise ArgumentError, 'Cart not found.' unless Cart.exists?(cart_id)
  end

  private

  def render_record_exception_response(exception)
    render json: { status: 'ERROR', message: exception.record.errors },
           status: :bad_request
  end

  def render_not_found_response(exception)
    render json: { status: 'ERROR', message: exception.message },
           status: :not_found
  end

  def render_bad_request_response(exception)
    render json: { status: 'ERROR', message: exception.message },
           status: :bad_request
  end
end
