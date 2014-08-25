# As an Admin/User
# In order to allow the users to select specific plants
# I want to create plant varieties
#
# Acceptance Criteria:
#
# The variety will have a unique name with max 30 characters
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
  scenario "Happy path, create a variety" do
pending "implementation"
    tomato = Fabricate(:category, name: "tomato", edible: true)
    visit categories_path
    click_link "tomato"
    click_on "add variety"
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    current_path.should eq category_path(tomato)
    page.should have_content("Cherry")
    page.should have_content("Small, sweet")
    page.should have_content("Cherry variety was created.")
  end
end
