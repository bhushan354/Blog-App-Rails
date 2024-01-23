require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:each) do
    @user = User.create(name: 'Bhushan',
                        photo: 'https://unsplash.comr-WE6A_jLpZwQ', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')

    6.times do |i|
      Comment.create(post: @post, author: @user, text: "My Comment #{i}")
    end
  end

  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'displays the user\'s profile picture' do
    visit user_posts_path(@user)
    expect(page).to have_selector("img[src*='#{@user.photo}']")
  end

  it 'shows the user\'s username.' do
    visit user_posts_path(@user)
    expect(page).to have_content @user.name
  end

  it 'indicates the number of posts the user has written.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'Number of Posts: 1'
  end

  it 'displays a post\'s title.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'This is my first post'
  end

  it 'shows some of the post\'s body.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'This is my first post'
  end

  it 'displays the first comments on a post.' do
    visit user_posts_path(@user)
    (1..5).each do |i|
      expect(page).to have_content "My Comment #{i}"
    end
  end

  it 'indicates how many comments a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Comments: 6/i, normalize_ws: true)
  end

  it 'indicates how many likes a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Likes: 0/i)
  end

  it 'displays a section for see all posts if there are more posts than fit on the view.' do
    10.times do |i|
      Post.create(author: @user, title: "Post #{i + 1}", text: "This is post number #{i + 1}")
    end

    visit user_posts_path(@user)
    expect(page).to have_css('div p', text: 'No comment . click on post to add new comment')
  end
end
