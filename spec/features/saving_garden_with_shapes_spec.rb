feature "Save garden", js: true do
  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  scenario "adding a shape, happy path" do
    user = Fabricate(:user)
    login_as user
    garden = Fabricate(:garden, user: user)

    visit edit_garden_path(garden)
    element = page.driver.find_css(".circle.green").first.native
    destination = page.driver.find_css("#garden-plot").first.native
    page.driver.browser.mouse.down(element)
    page.driver.browser.mouse.move_to(destination, 5, 5)
    page.driver.browser.mouse.up()

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.circle.green').position();")
    position['top'].should == 0
    position['left'].should == 0

    circle = Circle.last
    circle.garden.should == garden
    circle.top.should == 0
    circle.left.should == 0
    circle.color.should == Shape::GREEN
    circle.height.should == 60
    circle.width.should == 60
  end

  scenario "adding a shape, in the middle of the plot" do
    user = Fabricate(:user)
    login_as user
    garden = Fabricate(:garden, user: user)
    visit edit_garden_path(garden)

    element = page.driver.find_css(".rectangle.brown").first.native
    destination = page.driver.find_css("#garden-plot").first.native

    page.driver.browser.mouse.down(element)
    page.driver.browser.mouse.move_to(destination, 90, 115) # This is 115 because selenium demands it of us.
    page.driver.browser.mouse.up()

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.rectangle.brown').position();")

    position['top'].should == 90
    position['left'].should == 90

    rectangle = Rectangle.last
    rectangle.garden.should == garden
    rectangle.top.should == 90
    rectangle.left.should == 90
    rectangle.color.should == Shape::BROWN
    rectangle.height.should == 60
    rectangle.width.should == 60
  end

  scenario "if shapes exist, they show up when the page loads" do
    garden = Fabricate(:garden)
    circle = Fabricate(:circle, garden: garden, color: Shape::BROWN, top: 15, left: 45, width: 60, height: 90)
    square = Fabricate(:rectangle, garden: garden, color: Shape::GRAY, top: 150, left: 30, width: 45, height: 45)

    login_as garden.user
    visit edit_garden_path(garden)

    page.driver.evaluate_script("$('#shape_#{circle.id}').css('width');").should == "60px"
    page.driver.evaluate_script("$('#shape_#{circle.id}').css('height');").should == "90px"
    page.driver.evaluate_script("$('#shape_#{circle.id}').css('background-color');").should == "rgb(133, 87, 30)"

    page.driver.evaluate_script("$('#shape_#{square.id}').css('width');").should == "45px"
    page.driver.evaluate_script("$('#shape_#{square.id}').css('height');").should == "45px"
    page.driver.evaluate_script("$('#shape_#{square.id}').css('background-color');").should == "rgb(204, 204, 204)"

    position = page.driver.evaluate_script("$('#garden-plot').find('#shape_#{circle.id}').position();")
    position['top'].should == 15
    position['left'].should == 45

    position = page.driver.evaluate_script("$('#garden-plot').find('#shape_#{square.id}').position();")
    position['top'].should == 150
    position['left'].should == 30
  end

  scenario "moving items" do
    garden = Fabricate(:garden)
    circle = Fabricate(:circle, garden: garden, color: Shape::BROWN, top: 0, left: 0, width: 60, height: 60)

    login_as garden.user
    visit edit_garden_path(garden)

    page.driver.evaluate_script("$('#shape_#{circle.id}').css('width');").should == "60px"
    page.driver.evaluate_script("$('#shape_#{circle.id}').css('height');").should == "60px"
    position = page.driver.evaluate_script("$('#garden-plot').find('#shape_#{circle.id}').position();")
    position['top'].should == 0
    position['left'].should == 0

    element = page.driver.find_css("#shape_#{circle.id}").first.native
    page.driver.browser.mouse.down(element)
    page.driver.browser.mouse.move_by(60, 45)# right_by, down_by
    page.driver.browser.mouse.up()

    page.driver.evaluate_script("$('#shape_#{circle.id}').css('width');").should == "60px"
    page.driver.evaluate_script("$('#shape_#{circle.id}').css('height');").should == "60px"
    position = page.driver.evaluate_script("$('#garden-plot').find('#shape_#{circle.id}').position();")
    position['top'].should == 45
    position['left'].should == 60

    visit edit_garden_path(garden)

    page.driver.evaluate_script("$('#shape_#{circle.id}').css('width');").should == "60px"
    page.driver.evaluate_script("$('#shape_#{circle.id}').css('height');").should == "60px"
    position = page.driver.evaluate_script("$('#garden-plot').find('#shape_#{circle.id}').position();")
    position['top'].should == 45
    position['left'].should == 60
  end

  scenario "dragging to a non-grid item"
  scenario "removing an item from the grid"
  scenario "resizing items"
  scenario "overlapping items"
end
