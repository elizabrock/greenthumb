# As a user
# In order to plan out my flower garden
# I want to see what the garden will look like from the side
#
# When entering a plant, we need to enter how tall it will be
# When viewing the garden list, I want to see both the overhead and side views.
#
# Acceptance Criteria
#
# User will select a height and an width/length for new plants
# Plants will be assigned an x and y coordinate when placed in the garden
# User will click to switch side views, choosing from the 4 side angles
# Side view images of all garden plants will arrange to display the side view of the garden

feature "User views garden from side", :js => true do

  background do
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user)
    visit edit_garden_path(@garden)
  end
  
  scenario "Happy path, display name of initial side view" do
    page.should have_content("Front View")
  end
  
  scenario "Happy path, display name of side view after switching angles" do
    click_on "rotate_left"
    page.should have_content("Left View")
    click_on "rotate_left"
    page.should have_content("Rear View")
    click_on "rotate_right"
    click_on "rotate_right"
    click_on "rotate_right"
    page.should have_content("Right View")
  end

end