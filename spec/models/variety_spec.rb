require 'rails_helper'

RSpec.describe Variety, :type => :model do
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :name}
end
