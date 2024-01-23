require 'rails_helper'

RSpec.describe 'user_index_path testing', type: :system do
  describe 'User_index_path view' do
    before do
      @users = [
        User.create!(name: 'Bhushan', photo: '#Bhushan_photo', bio: 'random quote', posts_counter: 0),
        User.create!(name: 'Vrunda', photo: '#vrunda', bio: 'random quote', posts_counter: 0),
        User.create!(name: 'Vrunda', photo: '#Vrunda_photo', bio: 'random quote', posts_counter: 0)
      ]
      visit users_path
    end

    it 'can see username of all other users' do
      @users.each do |user|
        expect(page).to have_content user.name
      end
    end

    it 'can see the user profile picture' do
      @users.each do |user|
        expect(page).to have_selector("img[src*='#{user.photo}']")
      end
    end

    it 'can see the number of posts each user has written' do
      @users.each do |user|
        expect(page).to have_content("Posts: #{user.posts_counter}")
      end
    end

    it 'redirects to the user show page when clicking on a user' do
      user = @users.first
      click_link user.name
      expect(page).to have_current_path(user_path(user))
    end
  end
end
