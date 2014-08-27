# ## User creates a new garden plan

# As a user
# In order to design a new garden
# I want to create a new garden plan

# Acceptance Criteria:
# * User must be logged in

# Usage:
# * User clicks "Add Another Garden" (if they already have a garden) or "Setup your First Garden" (if this is their first garden)
# * The garden is created with an auto-generated name and default dimensions
# * The user is taken to the edit garden screen for that garden

feature "User creates a new garden" do
  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "when the user doesn't have any gardens" do
    click_button "Set up your First Garden"
    page.should have_content("Your garden has been created!")
    field_labeled("Garden Name")[:value].should eq("First Garden")
    field_labeled("Height")[:value].should eq("10")
    field_labeled("Width")[:value].should eq("10")
  end

  scenario "when the user already has a garden" do
    pending "Further implementation"
    Fabricate(:garden, user: @user)
    click_button "Add Another Garden"
    page.should have_content("Your garden has been created!")
    field_labeled("Garden Name")[:value].should eq("Second Garden")
    field_labeled("Height")[:value].should eq("10")
    field_labeled("Width")[:value].should eq("10")
  end

  scenario "when the user already has multiple gardens" do
    pending "Further implementation"
    Fabricate(:garden, user: @user)
    Fabricate(:garden, user: @user)
    click_button "Add Another Garden"
    page.should have_content("Your garden has been created!")
    field_labeled("Garden Name").should have_value("Third Garden")
  end
end
