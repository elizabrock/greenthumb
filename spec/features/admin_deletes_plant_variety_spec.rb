# As an Admin
# In order to protect the integrity of the site
# I want to delete a plant variety

# Acceptance Criteria:

# The Admin will be able to select a plant to delete from the Plants index page
# The Admin will be prompted wiht a confirmation of deleteing the plant variety
# When the plant is deleted, it should display a confirmation message
# Usage:

# From the Plant page for the plant in question:
# Admin will click the "Delete" button
# Admin will be prompted to confirm the deletion
# Redirected to index page with confirmation message of deleted plant

feature "User/Admin deletes plant variety" do

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
    @cherry = Fabricate(:variety, name: "Cherry", description: "small", category: @tomato)
    @brandywine = Fabricate(:variety, name: "Brandywine", description: "known for its flavor", category: @tomato)
    @amish = Fabricate(:variety, name: "Amish", description: "sweet but can be bland", category: @tomato)
  end

  scenario "Regular users can't access deleting plants" do
    login_as Fabricate(:user)
    visit edit_admin_category_variety_path(@tomato, @cherry)
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end

  scenario "Happy path, deletes first variety" do
    login_as Fabricate(:admin)
    visit edit_admin_category_variety_path(@tomato, @cherry)
    click_button "Delete"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Cherry")
    current_path.should eq admin_category_path(@tomato)
  end

  scenario "Happy path, deletes from middle of list" do
    login_as Fabricate(:admin)
    visit edit_admin_category_variety_path(@tomato, @brandywine)
    click_button "Delete"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Brandywine")
    current_path.should eq admin_category_path(@tomato)
  end
end
