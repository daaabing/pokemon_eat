class Like < ApplicationRecord
  validates :user_id, presence:true
  validates :business_id, presence:true
end
