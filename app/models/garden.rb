class Garden < ActiveRecord::Base
  before_create :populate_default_values

  protected

  def populate_default_values
    self.height ||= 10
    self.width ||= 10
    self.name ||= "First Garden"
  end
end
