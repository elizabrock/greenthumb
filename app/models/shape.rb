class Shape < ActiveRecord::Base
  GRAY  = "gray"
  GREEN = "green"
  BROWN = "brown"

  belongs_to :garden

  before_validation :populate_default_values
  validates_presence_of :garden, :color
  validates_inclusion_of :color, in: [BROWN, GRAY, GREEN]

  protected

  def populate_default_values
    self.top ||= 0
    self.left ||= 0
    self.height ||= 60
    self.width ||= 60
  end
end
