feature "Save garden" do

  background do
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user)
  end

  scenario "without shapes" do
    visit edit_garden_path(@garden.id)
    click_on "Save"
    page.should have_content("Your garden has been updated.")
  end

end
