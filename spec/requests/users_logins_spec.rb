require 'rails_helper'

RSpec.describe "Login", type: :request do
  describe "login with invalid information" do
    it "failed" do
      get login_path
      expect(response).to render_template :new
      post login_path, params: {session: { email: "", password: ""}}
      expect(response).to render_template :new
      expect(flash[:danger]).not_to be_empty
      get root_path
      expect(flash[:danger]).to be nil
    end
  end

  describe "login with valid information" do
    it "success" do
      user = create(:user, password: 'password')
      visit login_path
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: "password"
      click_button "Log in"
      expect(page).not_to have_link 'Log in', href: login_path
      expect(page).to have_link 'Log out', href: logout_path
      expect(page).to have_link 'Profile', href: user_path(user)
      click_on "Log out"
      delete logout_path
      expect(page).to have_link 'Log in', href: login_path
      expect(page).not_to have_link 'Log out', href: logout_path
      expect(page).not_to have_link 'Profile', href: user_path(user)
    end
  end
end
