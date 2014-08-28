# As a user,
# I want the ability to create a new account
# In order to plan my gardens.

# Acceptance Criteria:

# Able to input email, and password
# Validate that email and password are present
# Password should be encrypted in Database
# User account should be saved in Database

feature "Users signs up" do
  scenario "Happy Path, Sign Up and subsequent Sign In" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "eliza@example.com"
    fill_in "Password", with: "password1"
    click_button "Create My Account"
    current_path.should == gardens_path
    page.should have_content("Welcome to greenthumb, eliza@example.com!")
    page.should_not have_content("Sign Up")
    page.should_not have_content("Sign In")

    click_link "Sign Out"
    current_path.should == new_user_session_path
    fill_in "Email", with: "eliza@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Welcome back, eliza@example.com!")
  end

  scenario "Skipped email and password" do
    visit '/'
    click_link "Sign Up"
    click_button "Create My Account"
    page.should have_content("Your account could not be created.")
    page.should have_error("can't be blank", on: "Email")
    page.should have_error("can't be blank", on: "Password")
  end
end
