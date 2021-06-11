require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    User.create(name: 'NewUser', email: 'user@example.com', password: '1234567', password_confirmation: '1234567')
  end

  it 'fails when creating a post without a user' do
    expect(Post.create(content: 'Random content for a post').errors.full_messages).to eq(['User must exist'])
  end

  it 'succeeds when creating a post with a user' do
    user = User.last
    post = Post.create(content: 'Random content for a post', user_id: user.id)
    expect(post).to eq(Post.last)
  end

  it 'should have many comments' do
    t = Post.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many comments' do
    t = Post.reflect_on_association(:likes)
    expect(t.macro).to eq(:has_many)
  end
end
