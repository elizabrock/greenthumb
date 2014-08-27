# COMMIT EVERYTHANG COMMIT EVERYTHANG COMMIT EVERYTHANG COMMIT EVERYTHANG
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
    user = Fabricate(:user, email: "eliza@example.com", password: "password1")
    login_as user
  end

  scenario "with correct email (Happy Path)" do
    click_link "Profile"
    click_link "Edit email"
    fill_in "Email", with: "adam@example.com"
    click_button "Save"
    page.should have_content("Profile has been updated.")
  end

  scenario "but left new email blank (Sad Path)" do
    click_link "Profile"
    click_link "Edit email"
    fill_in "Email", with: ""
    click_button "Save"
    page.should have_error("Can't be blank.", on: "Email")
  end

end

feature "User changes profile password" do
  background do
    user = Fabricate(:user, email: "eliza@example.com", password: "password1")
    login_as user
  end

  scenario "with correct password (Happy Path)" do
    click_link "Profile"
    click_link "Edit password"
    fill_in "Password", with: "password2"
    click_button "Save"
    page.should have_content("Profile has been updated.")
  end

  scenario "but left new password blank (Sad Path)" do
    click_link "Profile"
    click_link "Edit password"
    fill_in "Email", with: ""
    click_button "Save"
    page.should have_error("Can't be blank.", on: "Password")
  end

end
