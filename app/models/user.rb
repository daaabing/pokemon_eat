class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password_digest, presence: true

  # def self.get_recommend(location)
  #   '''
  #   Get recommended restaurants for the user
  #   if user has food_preference, get 2 based on the preference and 1 randomly
  #   otherwise get 3 randomly
  #   input: location
  #   output: three restaurants
  #   '''
  #   # preference = User.find_by(id: id).food_preference   or
    
  # end




end