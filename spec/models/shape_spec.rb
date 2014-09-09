require 'rails_helper'

RSpec.describe Shape, :type => :model do
  it { should validate_presence_of :color }
  it { should validate_presence_of :garden }
  it { should ensure_inclusion_of(:color).in_array(["gray", "green", "brown"]) }

  context "default values" do
    let(:garden){ Fabricate(:garden) }
    let(:shape){ Fabricate.build(:shape, garden: garden) }

    context "if the values have been set" do
      before do
        shape.height = 200
        shape.width = 200
        shape.top = 20
        shape.left = 50
        shape.save!
        shape.reload
      end

      it "should have the given top position" do
        shape.top.should == 20
      end

      it "should have the given left position" do
        shape.left.should == 50
      end

      it "should have the given height" do
        shape.height.should == 200
      end

      it "should have the given width" do
        shape.width.should == 200
      end
    end
    context "if the values have not been set" do
      before do
        shape.save!
        shape.reload
      end

      it "should have the default top position" do
        shape.top.should == 0
      end

      it "should have the default left position" do
        shape.left.should == 0
      end

      it "should have the default height" do
        shape.height.should == 60
      end

      it "should have the default width" do
        shape.width.should == 60
      end
    end
  end
end
