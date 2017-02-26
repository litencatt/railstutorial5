require 'rails_helper'

RSpec.describe "UsersSignups" do
  describe "signup" do
    before do
      ActionMailer::Base.deliveries.clear
      visit signup_path
    end

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      before do
        fill_in "user[name]", with: ""
        fill_in "user[email]", with: "user@invalid"
        fill_in "user[password]", with: "foo"
        fill_in "user[password_confirmation]", with: "bar"
      end
      it "should not create a user" do
        expect{click_button submit}.not_to change(User, :count)
      end
      it "render sign up page" do
        click_button submit
        expect(current_path).to eq signup_path
      end
      it "render error notify" do
        click_button submit
        expect(find("#error_explanation")).to be_visible
        expect(page).to have_content("Name can't be blank")
      end
    end

    describe "with valid information" do
      before do
        fill_in "user[name]", with: "Example User"
        fill_in "user[email]", with: "user@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_button submit
      end

      it "sends activation mail" do
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it "should create a user" do
        user = User.first
        expect(user.activated?).to eq false
        # TODO: user.activation_tokenが取得できない
        visit edit_account_activation_path(user.activation_token, email: user.email)
        expect(user.reload.activated?).to eq true
        expect(current_path).to eq user_path(user)
      end

    end
  end
end
