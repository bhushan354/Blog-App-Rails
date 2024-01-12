require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).with_foreign_key(:author_id) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    subject { User.new(name: 'Shahadat Hossain',
    photo: 'https://photo.com', bio: 'A skilled design and installation.') }

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
end
