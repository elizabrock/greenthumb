feature "Save garden", js: true do
  before do
    Capybara.current_driver = :poltergeist
  end
  after do
    Capybara.use_default_driver
  end

  background do
    @user = Fabricate(:user)
    login_as @user
    @garden = Fabricate(:garden, user: @user)
  end

  scenario "adding a shape, happy path" do
    visit edit_garden_path(@garden)
    green_circle = find(".circle.green")
    garden = find("#garden-plot")
    green_circle.drag_to(garden)

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.circle.green').position();")
    position['top'].should == 0
    position['left'].should == 0

    circle = Circle.last
    circle.garden.should == @garden
    circle.top.should == 0
    circle.left.should == 0
    circle.color.should == Circle::GREEN
    circle.height.should == 60
    circle.width.should == 60
  end

  scenario "adding a shape, in the middle of the plot" do
    pending "implementation"
    visit edit_garden_path(@garden)
    brown_rectangle = find(".rectangle.brown")
    garden = find("#garden-plot")
    brown_rectangle.drag_to(garden, 50, 50)

    wait_for_ajax

    position = page.driver.evaluate_script("$('#garden-plot').find('.rectangle.brown').position();")
    position['top'].should == 50
    position['left'].should == 50

    rectangle = Rectangle.last
    rectangle.garden.should == @garden
    rectangle.top.should == 50
    rectangle.left.should == 50
    rectangle.color.should == Rectangle::BROWN
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
