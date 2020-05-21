FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    user_level { "user" }
    password { "123456789!password" }
    confirmed_at { Time.now.utc }

    factory :editor do
      sequence(:name) { |n| "editor #{n}" }
      sequence(:email) { |n| "editor#{n}@example.com" }
      user_level { "editor" }
    end

    factory :contributor do
      sequence(:name) { |n| "contributor #{n}" }
      sequence(:email) { |n| "contributor#{n}@example.com" }
      user_level { "contributor" }
    end

    factory :admin do
      sequence(:name) { |n| "admin #{n}" }
      sequence(:email) { |n| "admin#{n}@example.com" }
      user_level { "admin" }
    end
  end
end
