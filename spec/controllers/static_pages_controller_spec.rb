describe StaticPagesController do
  describe 'GET home' do
    it 'responce is 200 OK' do
      get :home
      expect(response.status).to eq 200
    end
  end
  describe 'GET help' do
    it 'responce is 200 OK' do
      get :help
      expect(response.status).to eq 200
    end
  end
  describe 'GET about' do
    it 'responce is 200 OK' do
      get :about
      expect(response.status).to eq 200
    end
  end
  describe 'GET contact' do
    it 'responce is 200 OK' do
      get :contact
      expect(response.status).to eq 200
    end
  end
end
