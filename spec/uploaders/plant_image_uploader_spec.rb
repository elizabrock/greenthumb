describe PlantImageUploader do
  include CarrierWave::Test::Matchers

  before do
    @variety = Fabricate(:variety)
    PlantImageUploader.enable_processing = true
    @uploader = PlantImageUploader.new(@variety, :side_image)
    file = File.open('spec/support/data/example_side_image.png')
    @uploader.store!(file)
  end

  after do
    PlantImageUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumbnail' do
    it 'should scale down to 40x40' do
      @uploader.thumb.should have_dimensions(40, 40)
    end
  end
end
