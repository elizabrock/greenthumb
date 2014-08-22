feature "Adding a plant category" do
  scenario "Happy Path" do
    pending "implementation"
    visit '/'
    click_on "Manage Plant Categories"
    click_on "Add Category"
    fill_in "Name", with: "Tomatoes"
    choose "True"
    click_on "Create Category"
    page.should have_content("The Tomatoes category has been created.")
    current_path.should == categories_path
    within("ul#categories") do
      page.should have_content("Tomatoes")
    end
  end

  scenario "skipping filling out the form" do
    pending "implementation"
    visit '/'
    click_on "Manage Plant Categories"
    click_on "Add Category"
    click_on "Create Category"
    page.should have_content("Category could not be created.")
    page.should have_error("can't be blank", on: "Name")
    page.should have_error("must be selected", on: "Edible")
  end
end
