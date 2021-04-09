class Friend < ApplicationRecord
  validates :user_id, presence:true
  validates :friend_id, presence:true

  def self.subscribe(user_id, friend_id)
    Friend.create({user_id:user_id, friend_id:friend_id})
  end

  def self.get_following_all(user_id)
    following = []
    if user_id != nil and Friend.where(user_id:user_id) != nil
      following = Friend.where(user_id:user_id).to_a
      following_id = []
      following.each do |f|
        if following_id.include?(f.friend_id) == false
          following_id.append(f.friend_id)
        end
      end
    end
    return following_id
  end
end
