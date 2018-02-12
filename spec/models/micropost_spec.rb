describe Micropost, type: :model do
  before do
    user = create(:user)
    @micropost = user.microposts.new(content: "Lorem ipsum")
  end

  it 'is invalid without user_id' do
    expect(@micropost).to be_valid
  end

  it 'order most recent first' do
    expect(microposts).to eq Micropost.first
  end
end
