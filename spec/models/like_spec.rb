require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'update_likes_counter' do
    it 'should update comments number' do
      user = User.create(name: 'Bhushan Deshmukh',
                         photo: 'https://photo.com', bio: 'A skilled design and installation.')

      post = Post.create(title: 'Post title', text: 'First post', author_id: user.id, comments_counter: 0,
                         likes_counter: 0)

      post.likes.create(user:)

      # here will be comments_counter not update_comments_counter method
      expect(post.likes_counter).to eq(1)
    end
  end
end
