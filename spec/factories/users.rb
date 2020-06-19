FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.name }
    password { 'password@123' }
    password_confirmation { 'password@123' }
    mobile_token { SecureRandom.uuid }
  end
end
