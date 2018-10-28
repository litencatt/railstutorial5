class AuthenticateController < Knock::AuthTokenController
  def entity_name
    'User'
  end
end
