class ApiController < ActionController::API
  include Knock::Authenticable
  before_action :authenticate_user

  def index
    if current_user
      render json: { message: 'ok' }, status: :ok
    end
  end
end
