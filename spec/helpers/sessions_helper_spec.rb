require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe SessionsHelper do
  before do
    @user = create(:user)
    remember(@user)
  end

  describe 'current_user returns right user when session is nil' do
  end

  describe 'current_user returns nil when remember digest is wrong' do
  end
end
