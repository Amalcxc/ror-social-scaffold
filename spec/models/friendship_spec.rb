require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'Succeeds when you create a friendship with user and friend' do
    user = User.new(name: 'valid3', email: 'valid@3', password: 'valid3', password_confirmation: 'valid3')
    user.save
    friend = User.new(name: 'valid4', email: 'valid@4', password: 'valid4', password_confirmation: 'valid4')
    friend.save
    expect(user.friendships.create(friend_id: friend.id,
                                   confirmed: nil)).to eql(Friendship.find_by(user_id: user.id))
  end
end