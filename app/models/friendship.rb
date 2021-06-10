class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate  :not_friends, :on => :create
  def not_friends
    if Friendship.where(user_id: friend_id, friend_id: user_id).exists? || Friendship.where(user_id: user_id, friend_id: friend_id).exists?
      self.errors.add(:user_id, 'Already friends!')
    end
  end  
end
