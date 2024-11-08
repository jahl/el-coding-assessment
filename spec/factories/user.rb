FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.org" }
    password { "123456" }

    trait :with_game_events do
      transient do
        game_events_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:game_event, evaluator.game_events_count, user: user)
      end
    end
  end
end