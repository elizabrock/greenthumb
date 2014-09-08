require 'rails_helper'

RSpec.describe Shape, :type => :model do
  it { should validate_presence_of :color }
  it { should validate_presence_of :garden }
end
