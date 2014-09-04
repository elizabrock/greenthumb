feature "User/Admin deletes plant variety" do

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
    @cherry = Fabricate(:variety, name: "Cherry", description: "small", category: @tomato)
    @brandywine = Fabricate(:variety, name: "Brandywine", description: "known for its flavor", category: @tomato)
    @amish = Fabricate(:variety, name: "Amish", description: "sweet but can be bland", category: @tomato)
  end

  scenario "Happy path, deletes first variety" do
    visit edit_category_variety_path(@tomato, @cherry)
    click_button "Delete"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Cherry")
    current_path.should eq category_path(@tomato)
  end

  scenario "Happy path, deletes from middle of list" do
    visit edit_category_variety_path(@tomato, @brandywine)
    click_button "Delete"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Brandywine")
    current_path.should eq category_path(@tomato)
  end
end
