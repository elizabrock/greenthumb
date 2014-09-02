feature "Index Page" do
  scenario "is displayed when loading the site" do
    visit '/'
    expect(page).to have_content("Student Caller")
  end
end
