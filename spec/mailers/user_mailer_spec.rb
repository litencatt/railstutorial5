require "rails_helper"

describe UserMailer, type: :mailer do
  describe "account_activation" do
    it do
      user = create(:user)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq "Account activation"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.body.encoded).to match user.name
      expect(mail.body.encoded).to match user.activation_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end
  describe "password_reset" do
    it do
      user = create(:user)
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq "Password reset"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.body.encoded).to match user.reset_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end

end
