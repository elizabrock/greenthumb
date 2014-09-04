class Variety < ActiveRecord::Base
  mount_uploader :side_image, PlantImageUploader
  mount_uploader :top_image, PlantImageUploader

  belongs_to :category
  validates_presence_of :category, :name
  validates_uniqueness_of :name, message: "already exists."

  def full_title
    "#{name} (#{description})"
  end
end
