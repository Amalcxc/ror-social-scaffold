require 'rails_helper'
RSpec.describe 'Posts', type: :describe do
  let(:user) do
    User.create(name: 'NewUser', email: 'newer@new.com', password: '123456', password_confirmation: '123456')
  end

  feature 'Sign in' do
    scenario 'Signing in with correct credentials' do
      login_as(user, scope: :user)
      visit '/users'
      expect(page).to have_content 'Sign out'
    end

    scenario 'When you click sign out your session is ended' do
      login_as(user, scope: :user)
      visit root_path
      click_link 'Sign out'
      expect(page).to have_content 'Sign in'
    end
  end

  feature 'Posts' do
    scenario 'Create the post in page' do
      login_as(user, scope: :user)
      visit '/posts'
      fill_in 'post_content', with: 'This is the content for the post'
      click_button 'Save'
      expect(page).to have_content 'Post was successfully created.'
    end
  end
end
