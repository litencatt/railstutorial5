RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other) { create(:other) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: user }
      expect(response).to have_http_status(:success)
      expect(response).to render_template :show
      expect(assigns(:user)). to eq user
    end
  end

  describe "GET #index" do
    it 'redirect to login page when not logged in' do
      get :index
      expect(flash[:danger]).to eq "Please log in."
      expect(response).to redirect_to login_url
    end
    it 'shows index page when logged in' do
      log_in_as(user)
      get :index
      expect(response).to render_template :index
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
      log_in_as(user)
      get :edit, params: { id: user }
      expect(flash).to be_empty
    end
    it "redirect to login when not logged in" do
      log_in_as(other)
      get :edit, params: { id: user }
      expect(flash).to be_empty
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #create" do
    it 'saves the new user in the database' do
      expect{
        post :create, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
    end
    it 'redirect to user page and shows success message' do
      post :create, params: { user: attributes_for(:user) }
      expect(flash[:info]).to eq "Please check your email to activate your account."
      expect(response).to redirect_to root_path
    end
  end

  describe "PATCH #update" do
    it 'success when logged in' do
      log_in_as(user)
      patch :update, params: { id: user, user: {name: user.name, email: user.email } }
      expect(flash[:success]).not_to be_empty
      expect(response).to redirect_to user
    end
    it 'redirect to root path when update other user' do
      log_in_as(other)
      patch :update, params: { id: user, user: {name: user.name, email: user.email } }
      expect(flash).to be_empty
      expect(response).to redirect_to root_url
    end
  end
end
