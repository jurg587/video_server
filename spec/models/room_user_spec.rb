require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  it { should belong_to(:room) }
  it { should belong_to(:user) }
end
