FactoryBot.define do
  factory :game_event do
    event_type { "completed" }
    occurred_at { "2024-11-08 00:18:18" }
    association :game
    association :user
  end
end
