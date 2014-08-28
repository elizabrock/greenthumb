# As an Admin
# In order to give the user a quality experience
# I want to edit the details of a plant variety
#
# Acceptance Criteria:
#
# The Admin will be able to select a plant to edit from an index page
# The variety's page will have a pre-populated form with the variety's information
# When the plant is saved, it should display a confirmation message that the plant has been updated
# All validations from Creating a Plant apply
# Usage:
#
# Admin will click "Plants", then select a variety of plant from list
# Admin will be greeted with a form populated with the variety's information, including:
# Name
# Description
# Admin will click the "Save" button to save changes
# Redirected to show page with confirmation message of saved plant

feature "User adds plant variety" do

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
    @cherry_tomato = Fabricate(:variety, name: "cherry", description: "small and sweet", category_id: @tomato.id)
    @beefsteak = Fabricate(:variety, name: "Beefsteak", description: "Good for sandwiches", category_id: @tomato.id)
    @heirloom = Fabricate(:variety, name: "Heirloom", description: "Not necessarily red", category_id: @tomato.id)

    visit category_path(@tomato.id)
    click_on "Edit cherry"
  end

  scenario "Form is pre-populated" do
    field_labeled("Name")[:value].should eq("cherry")
    field_labeled("Description")[:value].should eq("small and sweet")
  end

  scenario "Happy path, edit a variety" do
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Save Changes"
    page.should have_content("Cherry")
    page.should have_content("Small, sweet, and cherry-sized.  Red.")
    page.should have_content("The Cherry variety has been updated.")
    current_path.should eq category_variety_path(@cherry_tomato.category_id, @cherry_tomato.id)
  end

  scenario "Name is not entered" do
    fill_in "Name", with: ""
    click_button "Save Changes"
    page.should have_content("Variety could not be updated.")
    page.should have_error("can't be blank", on: "Name")
  end

  scenario "adds duplicate should not save" do
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Save Changes"
    visit category_path(@tomato.id)
    click_on "add variety"
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    page.should have_content("Variety could not be created.")
    page.should have_error("already exists.", on: "Name")
  end
end
