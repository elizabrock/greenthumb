# As a user
# In order to remove an unwanted garden plan
# I want to delete my garden plans

# Acceptance Criteria:

# User must be logged in
# User must have created at least one garden plan
# Usage:

# From home screen, user clicks on the garden plan in question
# User selects "Delete This Garden" from the bottom of the "Design" tab
# User is prompted to confirm the deletion
# The user sees a confirmation message
# User is redirected to the home page after deletion
# User remains on the current page if they choose not to delete the plan

feature "User deletes a garden plan" do
  before do
    Capybara.current_driver = :webkit
  end

  after do
    Capybara.use_default_driver
  end

  background do
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user, name: "The Best Garden")
    visit '/'
    page.should have_content("The Best Garden")
    click_link "The Best Garden"
  end

  scenario "deleting a garden - accept confirmation", js: true do
    accept_confirm do
      click_button "Delete This Garden"
    end
    page.should have_content("Your garden has been deleted.")
    current_path.should == gardens_path
    page.should_not have_content("The Best Garden")
  end

  scenario "deleting a garden - deny confirmation", js: true do
    dismiss_confirm do
      click_button "Delete This Garden"
    end
    current_path.should == edit_garden_path(@garden)
  end
end
