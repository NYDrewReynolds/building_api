class User < ActiveRecord::Base
  has_many :orders

  validates :name, uniqueness: true

  has_secure_password
end
