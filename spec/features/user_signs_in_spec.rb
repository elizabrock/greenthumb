# As a user,
# I want my credentials to be authenticated
# In order to log into the site.


# Acceptance Criteria:

# Able to input email and password
# Validate that email and password are present
# Password should be encrypted
# Ability to retrieve data from Database
# Valid email should match email in Database
# Valid password should be a matched to password in Database
# If user inputs an Invalid email or password a message will displayed letting them know of the error
# If user inputs correct email and password the user dashboard will be displayed to the user

feature "User Signs In" do
  background do
    Fabricate(:user, email: "eliza@example.com", password: "password!")
  end

  scenario "with the correct credentials" do
    visit '/'
    click_link "Sign In"
    fill_in "Email", with: "eliza@example.com"
    fill_in "Password", with: "password!"
    click_button "Sign In"
    page.should have_content("Welcome back, eliza@example.com!")
    current_path.should == gardens_path
  end

  scenario "with an email that hasn't been registered" do
    visit '/'
    click_link "Sign In"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password!"
    click_button "Sign In"
    page.should have_content("We could not sign you in. Please check your sign in information below.")
    field_labeled("Email")[:value].should include("joe@example.com")
    field_labeled("Password")[:value].should be_blank
  end

  scenario "with the incorrect password" do
    visit '/'
    click_link "Sign In"
    fill_in "Email", with: "eliza@example.com"
    fill_in "Password", with: "notmypassword"
    click_button "Sign In"
    page.should have_content("We could not sign you in. Please check your sign in information below.")
    field_labeled("Email")[:value].should include("eliza@example.com")
    field_labeled("Password")[:value].should be_blank
  end

  scenario "with blank form" do
    visit '/'
    click_link "Sign In"
    click_button "Sign In"
    page.should have_content("We could not sign you in. Please check your sign in information below.")
    page.should have_error("can't be blank", on: "Email")
    page.should have_error("can't be blank", on: "Password")
  end
end
