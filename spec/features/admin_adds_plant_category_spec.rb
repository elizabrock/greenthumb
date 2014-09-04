feature "Adding a plant category" do

  scenario "Regular users can't access adding plants" do
    login_as Fabricate(:user)
    visit root_path
    page.should_not have_link("Manage Plant Categories")
    visit new_admin_category_path
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end

  scenario "Happy Path" do
    login_as Fabricate(:admin)
    visit '/'
    click_on "Manage Plant Categories"
    click_on "Add Category"
    fill_in "Name", with: "Tomatoes"
    check "Edible"
    click_on "Create Category"
    page.should have_content("The Tomatoes category has been created.")
    current_path.should == admin_categories_path
    within("ul#categories") do
      page.should have_content("Tomatoes")
    end
  end

  scenario "skipping filling out the form" do
    login_as Fabricate(:admin)
    visit '/'
    click_on "Manage Plant Categories"
    click_on "Add Category"
    click_on "Create Category"
    page.should have_content("Category could not be created.")
    page.should have_error("can't be blank", on: "Name")
  end
end
