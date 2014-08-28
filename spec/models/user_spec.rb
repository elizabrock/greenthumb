require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    Fabricate(:user)
  end
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
  it { should have_many :gardens }

  let!(:user) { Fabricate(:user) }
  it "sends an email" do
    expect { user.deliver_reset_password_instructions! }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
