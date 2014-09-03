require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :webkit

Capybara.configure do |config|
  config.match = :prefer_exact
end
