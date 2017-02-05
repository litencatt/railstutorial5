module LoginMacros
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def log_in_action(user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "password"
    click_button "Log in"
  end
end
