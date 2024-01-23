require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { Post.new(title: 'Post title', text: 'First post', author_id: 2, comments_counter: 0, likes_counter: 0) }

    before { subject.save }

    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not(be_valid)
    end

    it "title shouldn't exceed 250 characters" do
      subject.title = 'a' * 251
      expect(subject).to_not(be_valid)
    end

    it 'should have a positive comments counter' do
      subject.comments_counter = -1
      expect(subject).to_not(be_valid)
    end

    it 'post_counter method should raise an error without a user' do
      expect { subject.post_counter }.to raise_error(NoMethodError)
    end

    it 'should have a positive likes counter' do
      subject.likes_counter = -1
      expect(subject).to_not(be_valid)
    end
  end

  describe 'update_user_posts_number' do
    it 'should update the number of posts' do
      user = User.create(name: 'Bhushan Deshmukh', photo: 'https://photos.com', bio: 'good human')

      expect(user.posts_counter).to eq(0)

      Post.create(title: 'Post title', text: 'First post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
      # this 'user.reload' is to ensure that the user's attributes are reloaded from the database
      user.reload

      expect(user.posts_counter).to eq(1)
    end
  end
end
