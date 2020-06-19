FactoryBot.define do
  factory :room do
    name { Faker::Name.unique.name }
    guid { SecureRandom.uuid }
  end
end
