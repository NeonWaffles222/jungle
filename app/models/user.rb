class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10 }

  private

  def self.authenticate_with_credentials(email, password)
    user = User.where('lower(email) = ?', email.strip.downcase).first

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
  
end
