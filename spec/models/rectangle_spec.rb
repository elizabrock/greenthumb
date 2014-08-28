require 'rails_helper'

RSpec.describe Rectangle, :type => :model do
  it { should validate_presence_of :garden_id }

  context "if the rectangle being created is already populated with values" do
    let(:garden){ Garden.create! }
    let(:rectangle){ Rectangle.new(color: "#cccccc", height: 200, width: 200, top: 20, left: 50, garden_id: garden.id) }

    before do
      rectangle.save!
    end

    it "should belong to the created garden" do
      rectangle.garden_id.should == garden.id
    end 

    it "should have the given color" do
      rectangle.color.should == "#cccccc"
    end 

    it "should have the given height" do
      rectangle.height.should == 200
    end

    it "should have the given width" do
      rectangle.width.should == 200
    end

    it "should have the given top position" do
      rectangle.top.should == 20
    end

    it "should have the given left position" do
      rectangle.left.should == 50
    end
  end

  context "if the rectangle is first being set" do
    let(:garden){ Garden.create! }
    let(:rectangle){ Rectangle.create(color: "#ffcc00", garden_id: garden.id) }

    before do
      rectangle.save!
    end

    it "should belong to the created garden" do
      rectangle.garden_id.should == garden.id
    end

    it "should should have the given color" do
      rectangle.color.should == "#ffcc00"
    end

    it "should have the default height" do
      rectangle.height.should == 100
    end

    it "should have the default width" do
      rectangle.width.should == 100
    end
  end
end
