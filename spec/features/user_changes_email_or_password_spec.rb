# As a user,
# In order to update where I get emails and how I log in,
# I want the ability to change my account information
#
# Acceptance Criteria:
#
# User can edit email and password
# New email or password should be saved to Database

feature "User changes profile email" do
  background do
    @user = Fabricate(:user, email: "eliza@example.com", password: "password1")
    login_as @user
  end

  scenario "with correct email & password (Super Happy Path)" do
    click_link "Profile"
    current_path.should == edit_user_path
    fill_in "Email", with: "adam@example.com"
    fill_in "Password", with: "password2"
    click_on "Save"
    User.authenticate("adam@example.com", "password2").should_not be_nil
    page.should have_content("Profile has been updated.")
  end

  scenario "with correct email (Happy Path)" do
    click_link "Profile"
    current_path.should == edit_user_path
    fill_in "Email", with: "adam@example.com"
    click_on "Save"
    User.authenticate("adam@example.com", "password1").should_not be_nil
    page.should have_content("Profile has been updated.")
  end
end

feature "User changes profile password" do
  background do
    @user = Fabricate(:user, email: "eliza@example.com", password: "password1")
    login_as @user
  end

  scenario "with correct password (Happy Path)" do
    click_link "Profile"
    current_path.should == edit_user_path
    fill_in "Password", with: "password2"
    click_button "Save"
    page.should have_content("Profile has been updated.")
    User.authenticate("eliza@example.com", "password2").should_not be_nil
    page.should have_content("Profile has been updated.")
  end
end
