class Review < ApplicationRecord
  validates :user_id, presence:true
  validates :business_id, presence:true
  validates :review, presence:true

  def self.get_user_reviews(user_id)
    reviews = []
    if user_id != nil and Review.where(user_id:user_id) != nil
      reviews = Review.where(user_id:user_id).to_a
    end
    return reviews
  end

end
