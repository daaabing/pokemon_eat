class Review < ApplicationRecord
  validates :user_id, presence:true
  validates :business_id, presence:true
  validates :review, presence:true

  def self.get_user_reviews(user_id)
    if user_id == nil or Review.where(user_id:user_id) == nil
      return []
    else
      return Review.where(user_id:user_id).to_a
    end
  end

end
