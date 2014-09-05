class Category < ActiveRecord::Base
  mount_uploader :side_image, PlantImageUploader
  mount_uploader :top_image, PlantImageUploader

  validates_presence_of :name
  has_many :varieties
end
