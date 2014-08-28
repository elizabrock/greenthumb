
feature "User edits an existing garden" do
  background do
    @user = Fabricate(:user)
    login_as @user
    click_button "Set up your First Garden"
  end

  scenario "when the user doesn't have any gardens" do
    page.should have_content("Your garden has been created!")
    fill_in "Garden Name", with: "Updated Garden"
    fill_in "Height", with: "20"
    fill_in "Width", with: "30"
    click_button "Save Changes"
    field_labeled("Garden Name")[:value].should eq("Updated Garden")
    field_labeled("Height")[:value].should eq("20")
    field_labeled("Width")[:value].should eq("30")
  end



# #   scenario "when the user already has multiple gardens" do
# #     pending "Further implementation"
# #     Fabricate(:garden, user: @user)
# #     Fabricate(:garden, user: @user)
# #     click_button "Add Another Garden"
# #     page.should have_content("Your garden has been created!")
# #     field_labeled("Garden Name").should have_value("Third Garden")
# #   end
end



    # click_link "Sign Out"
    # current_path.should == new_user_session_path
    # fill_in "Email", with: "eliza@example.com"
    # fill_in "Password", with: "password1"
    # click_button "Sign In"
    # page.should have_content("Welcome back, eliza@example.com!")