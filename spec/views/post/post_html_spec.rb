
RSpec.describe 'Post show page', type: :system do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @user2 = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/xyz', bio: 'Alice\'s bio.')
    @comment1 = Comment.create(post: @post, user: @user2, text: 'Great post!')
  end
  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end
