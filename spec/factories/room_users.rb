FactoryBot.define do
  factory :room_user do
    room
    user
    is_host { false }
  end
end
