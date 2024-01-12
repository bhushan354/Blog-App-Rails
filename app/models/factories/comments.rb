FactoryBot.define do
  factory :comment do
    content { 'This is a comment.' }
    association :user, factory: :user
    association :post, factory: :post
  end
end
