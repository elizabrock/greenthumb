feature "Save garden", js: true do
  after do
    Capybara.use_default_driver
  end

  scenario "adding a shape, happy path" do
    Capybara.current_driver = :selenium
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user)
    visit edit_garden_path(@garden)
    element = page.driver.find_css(".circle.green").first.native
    garden = page.driver.find_css("#garden-plot").first.native
    page.driver.browser.mouse.down(element)
    page.driver.browser.mouse.move_to(garden, 5, 5)
    page.driver.browser.mouse.up()

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.circle.green').position();")
    position['top'].should == 0
    position['left'].should == 0

    circle = Circle.last
    circle.garden.should == @garden
    circle.top.should == 0
    circle.left.should == 0
    circle.color.should == Shape::GREEN
    circle.height.should == 60
    circle.width.should == 60
  end

  scenario "adding a shape, in the middle of the plot" do
    Capybara.current_driver = :selenium
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user)
    visit edit_garden_path(@garden)

    element = page.driver.find_css(".rectangle.brown").first.native
    garden = page.driver.find_css("#garden-plot").first.native

    page.driver.browser.mouse.down(element)
    page.driver.browser.mouse.move_to(garden, 90, 115) # This is 115 because selenium demands it of us.
    page.driver.browser.mouse.up()

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.rectangle.brown').position();")

    position['top'].should == 90
    position['left'].should == 90

    rectangle = Rectangle.last
    rectangle.garden.should == @garden
    rectangle.top.should == 90
    rectangle.left.should == 90
    rectangle.color.should == Shape::BROWN
    rectangle.height.should == 60
    rectangle.width.should == 60
  end

  scenario "if shapes exist, they show up when the page loads"
  scenario "not duplicating when moving"
  scenario "dragging to a non-grid item"
  scenario "removing an item from the grid"
  scenario "moving items"
  scenario "resizing items"
  scenario "overlapping items"
end
