# As a Admin
# In order for user to be aware of all varieties of a plant
# I want to view a specific plant variety
#
# Acceptance Criteria:
#
#     The view page will list the name, images, description, and Amazon URL for variety
#
# Usage:
#
#     Admin will click "Plants", select a specific Plant Category, then click a specific plant
#     Admin will be greeted with a short profile of the variety including:
#         Name
#         Description
#         Images
#         Amazon URL

feature "Admin views a specific plant variety" do
  background do
    login_as Fabricate(:admin)
    @potato = Fabricate(:category, name: "Potato", edible: true)
    @yukon = Fabricate(:variety, name: "Yukon", description: "Not Cornelius", category: @potato)

    visit admin_categories_path
    click_link "Potato"
    click_link "Yukon"
  end

  scenario "displays details of a plant variety" do
    page.should have_content("Yukon")
    page.should have_content("Not Cornelius")
    current_path.should eq edit_admin_category_variety_path(@potato, @yukon)
  end
end
