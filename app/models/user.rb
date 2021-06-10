class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,  presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friends, -> { where confirmed: false }, class_name: 'Frienships', foreign_key: 'friend_id'
  
  # def friends
  #   friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
  #   (friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.confirmed })
  #   friends_array.compact
  # end

  def friends
    friends_i_sent_invitation = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation && friends_i_got_invitation
    User.where(id: ids)
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user, _friend)
    friendships = inverse_friendships.find { |friendship| friendship.user == user }
    friendships.confirmed = true
    friendships.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
