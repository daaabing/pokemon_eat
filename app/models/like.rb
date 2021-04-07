class Like < ApplicationRecord
  validates :user_id, presence:true, uniqueness: { scope: :business_id }
  validates :business_id, presence:true

  def self.like_this_res(business_id, user_id)
    entry = Like.create({user_id:user_id, business_id:business_id})
    entry.save()
  end

  def self.get_user_res(user_id)
    res = []
    if user_id != nil and Like.where(user_id:user_id) != nil
      res = Like.where(user_id:user_id).to_a
    end
    return res
  end
end
