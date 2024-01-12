require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    # described_class.reflect_on_association(:user): This line uses reflect_on_association method to
    # get information about the association between the Comment model and the User model.

    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      #   It checks that the association's macro (type) is :belongs_to
      expect(association.macro).to eq :belongs_to
      #   association's macro means type
      # In Rails, belongs_to is used to define a one-to-one association
    end
  end

  describe 'update_comments_number' do 
    it 'should update comments number' do
      user = User.create(name: 'Bhushan Deshmukh',
                         photo: 'https://photo.com', bio: 'A skilled design and installation.')

      post = Post.create(title: 'Post title', text: 'First post', author_id: user.id, comments_counter: 0,
                         likes_counter: 0)

      comment1 = post.comments.create(text: 'Comment 1', user:)

      # here will be comments_counter not update_comments_counter method
      expect(post.comments_counter).to eq(1)
    end
  end
end
