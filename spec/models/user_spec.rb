require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).with_foreign_key(:author_id) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    subject do
      User.new(name: 'Shahadat Hossain',
               photo: 'https://photo.com', bio: 'A skilled design and installation.')
    end

    before { subject.save }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not(be_valid)
    end

    it 'photo should not be null' do
      subject.photo = nil
      expect(subject).to(be_valid)
    end
  end

  describe 'recent_posts' do
    it 'should return 3 recent posts in descending order' do 
      user = User.create(name: 'Bhushan Deshmukh',
               photo: 'https://photo.com', bio: 'A skilled design and installation.')

      post1 = Post.create(title: 'Post title', text: 'First post', author_id: user.id, comments_counter: 0,likes_counter: 0)

      post2 = Post.create(title: 'Post title', text: 'second post', author_id: user.id, comments_counter: 0,
      likes_counter: 0)  

      post3 = Post.create(title: 'Post title', text: 'third post', author_id: user.id, comments_counter: 0,
      likes_counter: 0)   

      expect(user.recent_posts).to eq([post3, post2, post1])
    end
  end
end
