FactoryBot.define do
  factory :favorite_c do
    user
    post_c
  end

  factory :favorite_sitter do
    user
    post_sitter
  end
end
