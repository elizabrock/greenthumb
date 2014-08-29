
feature "User edits an existing garden" do
  background do
    @user1 = Fabricate(:user)
    @user2 = Fabricate(:user)
    @garden = Fabricate(:garden, user: @user1, name: "User1s Garden")
  end

  scenario "when the user edits the garden that is intially created for them" do
    login_as @user1
    click_link "User1s Garden"
    fill_in "Garden Name", with: "User1s Updated Garden"
    fill_in "Height", with: "40"
    fill_in "Width", with: "60"
    click_button "Save Changes"
    page.should have_content("User1s Updated Garden was successfully updated!")

    click_link "User1s Updated Garden"
    find_field("Garden Name").value.should eq 'User1s Updated Garden'
  end

  scenario "a user tries to access another user's garden edit page" do
    login_as @user2
    visit edit_garden_path(@garden)
    expect(page.current_path).to eq '/gardens'
  end

  scenario "a non logged in user tries to access another user's garden edit page" do
    visit edit_garden_path(@garden)
    expect(page.current_path).to eq '/'
  end

end
