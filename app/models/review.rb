class Review < ApplicationRecord
  validates :user_id, presence:true
  validates :business_id, presence:true
  validates :review, presence:true
end
