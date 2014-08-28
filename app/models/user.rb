class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :gardens

  validates_presence_of :email, :password
  validates_uniqueness_of :email
end
