class Review < ApplicationRecord
  validates :user_id, presence:true
  validates :business_id, presence:true
  validates :review, presence:true

  def self.get_user_reviews(user_id)
    #On the home page, we have Your-recent-reviews panel
    #So we need to retrive current user's reviews and send it back to the user_controller 
    reviews = []
    if user_id != nil and Review.where(user_id:user_id) != nil
      reviews = Review.where(user_id:user_id).to_a
    end
    return reviews
  end

end
