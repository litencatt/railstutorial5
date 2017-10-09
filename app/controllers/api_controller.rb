class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :api_authenticate

  def index
    render json: {message: 'ok'}, status: :ok
  end

  private

  def api_authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == 'lite-and-cat'
    end
  end

end
