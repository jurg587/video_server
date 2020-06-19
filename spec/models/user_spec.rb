require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:room_users) }
  it { should have_many(:rooms).through(:room_users) }
end
