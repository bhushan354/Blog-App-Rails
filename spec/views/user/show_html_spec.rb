require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'User show page' do
    before(:each) do
      @user = User.create!(name: 'Bhushan', photo: '#photo_Bhushan', bio: 'bio #Bhushan !', posts_counter: 0)

      10.times do |n|
        Post.create(author: @user, title: "#{n}/ Post ", text: "This is #{n} post")
      end

      visit user_path(@user.id)
    end

    after(:each) do
      User.destroy_all
    end

    it 'displays the user\'s profile picture' do
      expect(page).to have_selector("img[src*='#{@user.photo}']")
    end

    it 'shows the user\'s username' do
      expect(page).to have_content @user.name
    end

    it 'can see the number of posts the user has written.' do
      expect(page).to have_content(/Number of posts: 10/i)
    end

    it 'displays the user\'s bio' do
      expect(page).to have_content 'bio #Bhushan !'
    end

    it 'lists the user\'s first 3 posts' do
      (7..9).each do |n|
        expect(page).to have_content "This is #{n} post"
      end
    end

    it 'provides a button to view all of the user\'s posts' do
      expect(page).to have_content(/See All Posts/i)
    end

    it 'redirects to a post\'s show page when clicking on a post' do
      visit user_post_path(@user.id, @user.posts.first.id)
      expect(page).to have_content 'Like'
    end

    it 'redirects to the user\'s posts index page when clicking to see all posts' do
      visit user_posts_path(@user.id)

      (0..3).each do |n|
        expect(page).to have_content "This is #{n} post"
      end
    end
  end
end
