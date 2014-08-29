# As an admin
# In order to allow others to help me with my responsibilities
# I want to mark other users as admins
#
# Admins should see a link to "Manage Users" in the site footer
# The "Manage Users" link takes the admin to the users index page, which will list all the users
# Next to each user will be a button to either "Make Admin" or "Remove Admin Privileges"
# Click the appropriate button will add/remove the admin flag on the user
feature "admin gives a user admin rights" do

  background do
    @admin = Fabricate(:user, email: "will@nss.com", password: "password", admin: true)
    @user = Fabricate(:user, email: "matt@nss.com", password: "password", admin: false)
  end

  scenario "happy path" do
    visit '/'
    click_link "Sign In"
    fill_in "Email", with: "will@nss.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
    current_path.should == gardens_path
    click_link "Manage Users"
    page.should have_content("matt@nss.com")
    page.should have_content("will@nss.com")
    click_link "matt@nss.com"
    current_path.should == edit_user_path
    # check "admin"
    click_on "Update Administration Privileges"
    page.should have_content("administration privileges of matt@nss.com have been updated.")
    current_path.should == users_path
  end
end
