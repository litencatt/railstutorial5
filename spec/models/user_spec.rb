require 'rails_helper'

describe User do
  it 'is valid with a name and email' do
    user = create(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a name 51 characters or more' do
    user = build(:user, name: "a"* 51)
    user.valid?
    expect(user.errors[:name][0]).to include("too long")
  end

  it 'is invalid with a email 256 characters or more' do
    user = build(:user, email: "a"* 256)
    user.valid?
    expect(user.errors[:email][0]).to include("too long")
  end

  it 'is reject invalid email addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = build(:user, email: invalid_address)
      user.valid?
      expect(user.errors[:email][0]).to include("is invalid")
    end
  end

  it 'has onlry unique email address' do
    user = create(:user)
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    expect(duplicate_user.save).not_to eq true
  end

  it 'has only downcased email address' do
    address = "user@example.com"
    user = create(:user, email: address.upcase)
    expect(user.email).to eq address
  end

  it 'is invalid blank password' do
    user = create(:user)
    user.password = user.password_confirmation = " " * 6
    expect(user).to be_invalid
  end

  it 'is invalid password with 5 characters or less' do
    user = create(:user)
    user.password = user.password_confirmation = "a" * 5
    expect(user).to be_invalid
  end

  it 'returns false when authenticated? for a user with nil digest' do
    user = create(:user, remember_digest: nil)
    expect(user.authenticated?(:remember, '')).to be_falsey
  end
end
