feature "User/Admin deletes plant variety" do

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
    @cherry = Fabricate(:variety, name: "Cherry", description: "small", category_id: @tomato.id)
    @brandywine = Fabricate(:variety, name: "Brandywine", description: "known for its flavor", category_id: @tomato.id)
    @amish = Fabricate(:variety, name: "Amish", description: "sweet but can be bland", category_id: @tomato.id)
  end

  scenario "Happy path, deletes first variety" do
    visit category_path(@tomato)
    click_button "Delete Cherry"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Cherry")
    current_path.should eq category_path(@tomato)
  end

  scenario "Happy path, deletes from middle of list" do
    visit category_path(@tomato)
    click_button "Delete Brandywine"
    page.should have_content("Variety has been deleted.")
    page.should_not have_content("Brandywine")
    current_path.should eq category_path(@tomato)
  end
end
