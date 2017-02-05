require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
    @other = create(:other)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: @user
      expect(response).to have_http_status(:success)
      expect(response).to render_template :show
    end
  end
  describe "GET #index" do
    it 'redirect to login page when not logged in' do
      get :index
      expect(response).to redirect_to login_url
    end
  end
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template :new
    end
  end
  describe "GET #edit" do
    it "success when logged in" do
      log_in_as(@user)
      get :edit, id: @user
      expect(flash).to be_empty
    end
    it "redirect to login when not logged in" do
      log_in_as(@other)
      get :edit, id: @user
      expect(flash).not_to be_empty
      expect(response).to redirect_to login_url
    end
  end

  describe "POST #create"

  describe "PATCH #update" do
    it 'redirect to login when logged in as wrong user' do
      log_in_as(@other)
      patch :update, id: @user, user: {name: @user.name, email: @user.email }
      expect(flash).not_to be_empty
      expect(response).to redirect_to login_url
    end
  end
end
