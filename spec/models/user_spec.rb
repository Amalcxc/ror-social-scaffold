require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    User.create(name: 'NewUser', email: 'user@example.com', password: '1234567', password_confirmation: '1234567')
  end

  it 'checks the user exists' do
    expect(User.last.name).to eq('NewUser')
  end

  it 'Succeeds when you create a user with valid inputs' do
    expect(User.create(name: 'NewerUser',
                       email: 'user@newer.com',
                       password: '123456',
                       password_confirmation: '123456')).to eq(User.find_by(name: 'NewerUser'))
  end

  it 'It fails if wrong parameters are passed' do
    user = User.create(name: '', email: '', password: '', password_confirmation: '')
    expect(user.errors.full_messages).to eq(["Email can't be blank", "Password can't be blank", "Name can't be blank"])
  end

end
