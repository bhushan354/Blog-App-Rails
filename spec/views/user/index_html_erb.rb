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
        expect(page).to have_content user.photo
      end
    end
  end
end
