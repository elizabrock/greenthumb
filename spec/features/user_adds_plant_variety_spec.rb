# As an Admin/User
# In order to allow the users to select specific plants
# I want to create plant varieties
#
# Acceptance Criteria:
#
# Record the User that created the plant variety
# The variety will have an option to upload an image for the overhead and side views (ohterwise inherit from category)
# Description will have max length of 200 characters
# Link to purchase from store (Amazon)
# Usage:
#
# Admin will click "Plants", then "Add a variety"
# Admin will fill out form with name, description, and category
# Image upload fields, Amazon URL optional
# Admin will click 'Create'
# Redirected back to "Plant Varieties" index

feature "User adds plant variety" do

  background do
    @tomato = Fabricate(:category, name: "Tomato", edible: true)
    visit categories_path
    click_link "Tomato"
    click_on "Add New Tomato Variety"
  end

  scenario "Happy path, create a variety" do
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    page.should have_content("Cherry")
    page.should have_content("Small, sweet")
    page.should have_content("Cherry variety has been created.")
    current_path.should eq category_path(@tomato)
  end

  scenario "Name is not entered" do
    click_button "Create New Variety"
    page.should have_content("Variety could not be created.")
    page.should have_error("can't be blank", on: "Name")
  end

  scenario "adds duplicate should not save" do
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    click_on "Add New Tomato Variety"
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    page.should have_content("Variety could not be created.")
    page.should have_error("already exists.", on: "Name")
  end
end
