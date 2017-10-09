class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :api_authenticate

  def index
    render json: { message: 'ok' }, status: :ok
  end

  private

  def api_authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      token == 'lite-and-cat'
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { message: 'Bad credentials' }, status: :unauthorized
  end

end
