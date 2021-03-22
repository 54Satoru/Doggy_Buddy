FactoryBot.define do
  factory :post_c do
    user
    title          { "広島市ですお願いします" }
    region         { "広島市" }
    datetime       { "2021年4月18日" }
    price          { "¥4,000" }
    payment        { "現地で手渡し" }
    content        { "よろしくおねがいします" }
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end

  factory :post_sitter do
    user
    title          { "広島市ですお願いします" }
    region         { "広島市" }
    datetime       { "2021年4月20日~4月22日" }
    price          { "¥3,800" }
    payment        { "現地で手渡し" }
    content        { "よろしくおねがいします" }
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end
