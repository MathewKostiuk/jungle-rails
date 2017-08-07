class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews


  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }
end
