class Category < ActiveRecord::Base
  mount_uploader :side_image, CategoryImageUploader

  validates_presence_of :name
  has_many :varieties
end
