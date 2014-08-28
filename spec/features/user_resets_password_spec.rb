RSpec.describe UserMailer do
  # background do
  #   @user = Fabricate(:user)
  #   login_as @user
  # end

  describe 'resetting password' do
    it "sends an email to reset password when logged in" do
      pending "controller implementation"
      @user = Fabricate(:user)
      login_as @user
      visit '/'
      click_link 'My Profile'
      click_link 'Reset Password'
    end
  end
end