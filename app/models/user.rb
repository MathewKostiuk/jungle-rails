class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, uniqueness: true
end
