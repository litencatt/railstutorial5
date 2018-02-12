class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # sessionへの保存
        log_in user
        # cookiesへの保存
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)

        redirect_back_or user
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def oauth_redirect
    omniauth = request.env['omniauth.auth']

    user = transaction do
      oauth = UserOauth.find_by(
        provider: omniauth['provider'],
        uid: omniauth['uid'],
        token: omniauth['credentials']['token']
      )

      user = User.create!(
        name: omniauth['info']['name'],
        email: omniauth['info']['email'],
        password: BCrypt::Password.create(SecureRandom.hex),
        activated: true
      )

      oauth.update_attributes!(user_id: user.id)
      user
    end

    log_in user
    redirect_back_or user
  rescue
    redirect_to root_path
  end

end
