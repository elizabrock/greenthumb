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

feature "Admin edits plant variety" do

  def navigate_to_cherry_as_admin
    login_as Fabricate(:admin)
    visit category_path(@tomato)
    click_on "cherry"
  end

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
    @cherry_tomato = Fabricate(:variety, name: "cherry", description: "small and sweet", category: @tomato)
    @beefsteak = Fabricate(:variety, name: "Beefsteak", description: "Good for sandwiches", category: @tomato)
    @heirloom = Fabricate(:variety, name: "Heirloom", description: "Not necessarily red", category: @tomato)
  end

  scenario "user attempts to edit plant variety" do
    login_as Fabricate(:user)
    visit edit_category_variety_path(@tomato, @cherry_tomato)
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end

  scenario "Form is pre-populated" do
    navigate_to_cherry_as_admin
    field_labeled("Name")[:value].should eq("cherry")
    field_labeled("Description")[:value].should eq("small and sweet")
  end

  scenario "Happy path, edit a variety" do
    navigate_to_cherry_as_admin
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Save Changes"
    page.should have_content("Cherry")
    page.should have_content("Small, sweet, and cherry-sized.  Red.")
    page.should have_content("The Cherry variety has been updated.")
    current_path.should eq edit_category_variety_path(@cherry_tomato.category, @cherry_tomato)
  end

  scenario "Happy path, edit a variety that already has an image" do
    navigate_to_cherry_as_admin
    image1 = File.open('spec/support/data/example_side_image.png')
    image2 = File.open('spec/support/data/example_top_image.png')
    @image_variety = Fabricate(:variety, category: @tomato, side_image: image1, top_image: image2)
    visit edit_category_variety_path(@tomato, @image_variety)
    find(".side_image")[:src].should include("thumb_example_side_image")
    find(".top_image")[:src].should include("thumb_example_top_image")
    fill_in "Name", with: "Best Tomato"
    click_button "Save Changes"
    page.should have_content("The Best Tomato variety has been updated.")
    find(".side_image")[:src].should include("thumb_example_side_image")
    find(".top_image")[:src].should include("thumb_example_top_image")
  end

  scenario "Happy path, edit a variety to add an image" do
    navigate_to_cherry_as_admin
    page.should_not have_css(".side_image")
    page.should_not have_css(".top_image")
    attach_file 'Top Image', 'spec/support/data/example_top_image.png'
    attach_file 'Side Image', 'spec/support/data/example_side_image.png'
    click_button "Save Changes"
    page.should have_content("The cherry variety has been updated.")
    find(".side_image")[:src].should include("thumb_example_side_image")
    find(".top_image")[:src].should include("thumb_example_top_image")
  end

  scenario "Name is not entered" do
    navigate_to_cherry_as_admin
    fill_in "Name", with: ""
    click_button "Save Changes"
    page.should have_content("Variety could not be updated.")
    page.should have_error("can't be blank", on: "Name")
  end

  scenario "adds duplicate should not save" do
    navigate_to_cherry_as_admin
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Save Changes"
    visit category_path(@tomato)
    click_on "Add New tomato Variety"
    fill_in "Name", with: "Cherry"
    fill_in "Description", with: "Small, sweet, and cherry-sized.  Red."
    click_button "Create New Variety"
    page.should have_content("Variety could not be created.")
    page.should have_error("already exists.", on: "Name")
  end
end
