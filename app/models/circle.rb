class Circle < ActiveRecord::Base
  before_create :populate_default_values
  belongs_to :garden
  validates_presence_of :garden, :color

  GREEN = "green"

  protected

  def populate_default_values
    self.height ||= 60
    self.width ||= 60
  end
end
