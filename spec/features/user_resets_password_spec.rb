feature "User resets password" do
  scenario 'Happy path, reset password and log in' do
    @user = Fabricate(:user)
    visit '/'
    click_link 'Sign In'
    click_link 'Reset your password'
    fill_in "Email", with: @user.email
    click_on "Send Email"
    @user = User.find_by_email(@user.email)
    visit "/password_resets/#{@user.reset_password_token}/edit"
    fill_in "New password", with: 'abc123'
    fill_in "Password confirmation", with: 'abc123'
    click_on "Submit"

    current_path.should == root_path
    page.should have_content("Password was successfully updated.")
    click_link "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "abc123"
    click_button "Sign In"
    page.should have_content("Welcome back, #{@user.email}")
    current_path.should == gardens_path
  end

  scenario 'Sad path, email is not regisered in the database' do
    @user = Fabricate(:user)
    visit '/'
    click_link 'Sign In'
    click_link 'Reset your password'
    fill_in "Email", with: "abc" + @user.email
    click_on "Send Email"
    current_path.should == root_path
    page.should have_content("Couldn't find user.")
  end

  scenario 'Sad path, password confirmation does not match new password' do
    @user = Fabricate(:user)
    visit '/'
    click_link 'Sign In'
    click_link 'Reset your password'
    fill_in "Email", with: @user.email
    click_on "Send Email"
    @user = User.find_by_email(@user.email)
    visit "/password_resets/#{@user.reset_password_token}/edit"
    fill_in "New password", with: 'abc123'
    fill_in "Password confirmation", with: 'bbc123'
    click_on "Submit"

    current_path.should == "/password_resets/#{@user.reset_password_token}"
    page.should have_content("Passwords do not match.")
  end
end