class Rectangle < ActiveRecord::Base
  before_create :populate_default_values
  belongs_to :garden
  validates_presence_of :garden_id, :color

  protected

  def populate_default_values
    self.height ||= 100
    self.width ||= 100
  end
end
