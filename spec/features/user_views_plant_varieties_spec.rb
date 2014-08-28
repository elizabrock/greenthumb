# As a user
# I want to see a list of all of the plant categories and their corresponding varieties
# So that I can select a specific plant to add to the garden
#
# Acceptance Criteria
#
# User must be logged in and on the garden edit page
# All plant categories must appear in the drop down
# Once a category is selected, the name of the category appears in the drop down box
# If no plant categories exist, No plants available should appear in the drop down box
# If a selected category has no plant varieties exist, No plant varieties should appear in the drop down box
# All varieties must appear in the drop down list after a category is selected
# Usage
#
# From the garden edit page
# User clicks on the Plants tab
# User clicks on the Add drop/down
# The drop down expands to show the listing of all plant categories
# The user clicks on a plant category
# The drop down list shows all of the plant varieties for the selected category

feature "User views plant varieties" do
  background do
    @tomatoes = Fabricate(:category, name: "Tomatoes", edible: true)
    Fabricate(:category, name: "Squash", edible: true)
    Fabricate(:variety, name: "Cherry", description: "some description", category: @tomatoes)
    Fabricate(:variety, name: "Grape", description: "some description", category: @tomatoes)
    @user = Fabricate(:user)
    @garden = Fabricate(:garden)
    login_as @user
    visit edit_garden_path(@garden)
    click_on "Plants"
    click_on "Add"
  end

  scenario "Happy path - user finds what they're looking for" do
    pending "Further implementation"
    Category.count.should == 2
    Category.first.name.should == "Tomatoes"
    page.should have_content("Tomatoes")
    page.should have_content("Squash")
    page.select "Tomatoes"
    page.should have_content("Cherry")
    page.should have_content("Grape")
  end

  scenario "No categories exist" do
    pending "Further implementation"
    page.should have_content("No plants available")
  end

  scenario "No variety for selected category" do
    pending "Further implementation"
    click_on "Tomatoes"
    page.should have_content("No plant varieties")
  end
end
