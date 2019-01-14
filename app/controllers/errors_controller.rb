class ErrorsController < ApplicationController
  def render_not_found
    requested_path = request.path
    request_method = request.method
    render json: { status: 'ERROR',
                   message: 'Invalid request [' + request_method +
                            '] ' + requested_path }, status: :not_found
  end
end
