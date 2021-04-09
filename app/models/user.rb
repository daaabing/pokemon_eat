class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password_digest, presence: true

  def self.get_user(user_id)
    if user_id != nil and Review.where(user_id:user_id) != nil
      return User.find_by_id(user_id)
    end
  end
end