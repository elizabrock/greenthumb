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
	background do
		@user = Fabricate(:user)
		login_as @user
	end

	scenario "deleting your first garden" do
		click_button "Set up your First Garden"
		click_button "Delete This Garden"
		page.should have_content("Your garden has been deleted.")
		current_path.should == root_path
	end

end