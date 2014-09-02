feature "Adding a student" do
  scenario "Happy Path" do
    visit '/'
    click_on "Add Student"
    fill_in "Name", with: "Adam"
    click_on "Submit"
    page.should have_content("Student created")
  end

  scenario "but skipping Name" do
    visit '/'
    click_on "Add Student"
    click_on "Submit"
    page.should have_content("could not be created")
  end
end
