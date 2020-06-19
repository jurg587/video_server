require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_many(:room_users) }
  it { should have_many(:users).through(:room_users) }
end
