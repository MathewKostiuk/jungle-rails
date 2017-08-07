class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    stripped = email.strip
    if User.find_by_email(stripped) == nil
      nil
    elsif User.find_by_email(stripped).password == password
      User.find_by_email(stripped)
    else
      nil
    end
  end
end
