feature "Welcome page" do
  scenario "when logged out" do
    visit '/'
    page.should have_content("Anyone can have a GreenThumb!")
  end

  scenario "when logged in as a user with gardens" do
    user = Fabricate(:user)
    login_as user
    Fabricate(:garden, name: "Front Yard", user: user)
    Fabricate(:garden, name: "Back Yard", user: user)
    Fabricate(:garden, name: "Someone Else's Garden")
    visit '/'
    page.should have_content("Front Yard")
    page.should have_content("Back Yard")
    page.should_not have_content("Someone Else's Garden")
    page.should_not have_content("You don't have any gardens yet!")
  end

  scenario "when logged in as a user with no gardens" do
    user = Fabricate(:user)
    login_as user
    visit '/'
    page.should have_content("You don't have any gardens yet!")
  end
end
