class Garden < ActiveRecord::Base
  before_create :populate_default_values
  belongs_to :user

  belongs_to :user
  validates_presence_of :user

  protected

  def populate_default_values
    self.height ||= 10
    self.width ||= 10
    unless self.name.present?
      garden_number = user.gardens.count + 1
      garden_name = (garden_number == 1) ? "First" : garden_number.ordinalize
      self.name = "#{garden_name} Garden"
    end
  end
end
