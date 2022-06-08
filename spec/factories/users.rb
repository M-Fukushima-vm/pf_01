FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    avatar_name { "MyString" }
    introduction { "MyText" }
  end
end
