RSpec.describe UserMailer do
  # background do
  #   @user = Fabricate(:user)
  #   login_as @user
  # end

  describe 'resetting password' do
    it "sends an email to reset password when not logged in" do
      pending "further implementation"
      @user = Fabricate(:user)
      visit '/'
      click_link 'Sign In'
      click_link 'Reset your password'
      fill_in "Email", with: @user.email
      click_on "Send Email"
      puts "/password_resets/#{@user.reset_password_token}/edit"
      visit "/password_resets/#{@user.reset_password_token}/edit"
      fill_in "Email", with: @user.email
      fill_in "Password", with: 'abc123'
      fill_in "PasswordConfirmation", with: 'abc123'
      click_on "Submit"
    end
  end
end