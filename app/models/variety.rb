class Variety < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :category_id, :name
  validates_uniqueness_of :name, message: "already exists."
end
