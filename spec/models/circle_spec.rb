require 'rails_helper'

RSpec.describe Circle, :type => :model do
  it { should validate_presence_of :garden_id }

  context "if the circle being created is already populated with values" do
    let(:garden){ Garden.create! }
    let(:circle){ Circle.new(color: "#cccccc", height: 200, width: 200, top: 20, left: 50, garden_id: garden.id) }

    before do
      circle.save!
    end

    it "should belong to the created garden" do
      circle.garden_id.should == garden.id
    end 

    it "should have the given color" do
      circle.color.should == "#cccccc"
    end 

    it "should have the given height" do
      circle.height.should == 200
    end

    it "should have the given width" do
      circle.width.should == 200
    end

    it "should have the given top position" do
      circle.top.should == 20
    end

    it "should have the given left position" do
      circle.left.should == 50
    end
  end

  context "if the circle is first being set" do
    let(:garden){ Garden.create! }
    let(:circle){ Circle.create(color: "#ffcc00", garden_id: garden.id) }

    before do
      circle.save!
    end

    it "should belong to the created garden" do
      circle.garden_id.should == garden.id
    end

    it "should should have the given color" do
      circle.color.should == "#ffcc00"
    end

    it "should have the default height" do
      circle.height.should == 100
    end

    it "should have the default width" do
      circle.width.should == 100
    end
  end
end
