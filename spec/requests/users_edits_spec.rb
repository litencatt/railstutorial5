describe "UsersEdits", type: :request do
  let(:user) { create(:user, password: 'password', activated: true) }

  describe "logged in" do
    before do
      log_in_action(user)
      visit edit_user_path(user)
    end

    describe "unsuccessful edit" do
      it "error" do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: 'foo@invalid'
        fill_in 'user[password]', with: 'foo'
        fill_in 'user[password_confirmation]', with: 'bar'
        click_button 'Save changes'

        expect(page).to have_css('div', id: 'error_explanation')
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Email is invalid")
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(page).to have_content("Password is too short (minimum is 6 characters)")
      end
    end

    describe 'successful edit' do
      it 'success' do
        name = "Foo Bar"
        email = "foo@bar.com"
        fill_in 'user[name]', with: name
        fill_in 'user[email]', with: email
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'Save changes'

        expect(page).not_to have_css('div', id: 'error_explanation')
        user.reload
        expect(name).to eq user.name
        expect(email).to eq user.email
      end
    end
  end

  describe "not logged in" do
    before do
      visit edit_user_path(user)
    end

    describe 'not logged in access' do
      it 'redirect to login page'do
        expect(current_path).to eq login_path
      end
      it 'redirect to edit page, after logged in'do
        log_in_action(user)
        expect(current_path).to eq edit_user_path(user)
      end
    end
  end
end
