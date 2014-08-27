require 'rails_helper'

RSpec.describe Garden, :type => :model do
  describe "default values" do
    context "if the garden being created is already populated with values" do
      let(:garden){ Garden.new(name: "Awesome", height: 3, width: 4) }

      before do
        garden.save!
      end

      it "should have the given height" do
        garden.height.should == 3
      end
      it "should have the given width" do
        garden.width.should == 4
      end
      it "should have the given name" do
        garden.name.should == "Awesome"
      end
    end

    context "if the garden being created has no values set" do
      let(:garden){ Garden.create! }

      it "should have the default height" do
        garden.height.should == 10
      end
      it "should have the default width" do
        garden.width.should == 10
      end
      it "should have a default name" do
        garden.name.should == "First Garden"
      end
    end
  end
end
