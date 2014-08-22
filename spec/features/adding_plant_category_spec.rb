feature "Adding a plant category" do
  scenario "Happy Path" do
    visit '/'
    click_on "Manage Plant Categories" # index
    click_on "Add Category" # new
    fill_in "Name", with: "Tomatoes"
    check "Edible"
    click_on "Create Category" # create, then index
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
  end
end
