FactoryBot.define do
  factory :review do
    user
    association :reviewee_id, factory: :user
    content           { Faker::Lorem.sentence }
    rate              { "5" }
    position          { "sitter" }
  end
end
