# As an admin
# In order to allow others to help me with my responsibilities
# I want to mark other users as admins
#
# Admins should see a link to "Manage Users" in the site footer
# The "Manage Users" link takes the admin to the users index page, which will list all the users
# Next to each user will be a button to either "Make Admin" or "Remove Admin Privileges"
# Click the appropriate button will add/remove the admin flag on the user
feature "Admin gives a user admin rights" do

  background do
    @user = Fabricate(:user, email: "matt@nss.com")
    @admin = Fabricate(:admin, email: "will@nss.com")
  end

  scenario "happy path, give privileges" do
    login_as @admin
    current_path.should == gardens_path
    click_link "Manage Users"
    current_path.should == admin_users_path
    page.should have_content("matt@nss.com")
    page.should have_content("will@nss.com")
    click_on "Make Admin"
    page.should have_content("Administration privileges of matt@nss.com have been updated.")
    current_path.should == admin_users_path

    click_link "Sign Out"
    login_as @user
    page.should have_link("Manage Users")
  end

  scenario "happy path, remove privileges" do
    login_as @admin
    current_path.should == gardens_path
    click_link "Manage Users"
    current_path.should == admin_users_path
    page.should have_content("matt@nss.com")
    page.should have_content("will@nss.com")
    click_on "Remove Admin Privileges"

    visit admin_users_path
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end

  scenario "non admin cannot manage users" do
    login_as @user
    visit '/'
    page.should_not have_link("Manage Users")
    visit admin_users_path
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end
end
