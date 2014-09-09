require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.configure do |config|
  config.match = :prefer_exact
end

module CapybaraExtension
  def drag_by(right_by, down_by)
    base.drag_by(right_by, down_by)
  end

  def click_and_hold(element)
    base.click_and_hold(element)
  end

  def release()
    base.release()
  end

  def move_to_element(element, x=0, y=0)
    base.move_to_element(element, x, y)
  end

  def find_element(*args)
    base.find_element(*args)
  end
end

module CapybaraSeleniumExtension
  def drag_by(right_by, down_by)
    driver.browser.action.drag_and_drop_by(native, right_by, down_by).perform
  end

  def click_and_hold(element)
    driver.browser.action.click_and_hold(element).perform
  end

  def release()
    driver.browser.action.release().perform
  end

  def move_to_element(element, x=0, y=0)
    driver.browser.action.move_to_element(element, x, y).perform
  end

  def find_element(*args)
    driver.browser.action.find_element(*args).perform
  end
end

::Capybara::Selenium::Node.send :include, CapybaraSeleniumExtension
::Capybara::Node::Element.send :include, CapybaraExtension
