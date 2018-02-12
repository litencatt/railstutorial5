describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { user.microposts.create(content: "Lorem ipsum") }

  it 'is invalid without user_id' do
    expect(micropost).to be_valid
  end

  it 'order most recent first' do
    expect(micropost).to eq Micropost.first
  end
end
