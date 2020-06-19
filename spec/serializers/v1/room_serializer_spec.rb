require 'rails_helper'

describe V1::RoomSerializer do
  describe 'application user' do
    it 'includes the expected attributes' do
      room_user = create(:room_user, is_host: true)
      room_user_2 = create(:room_user, room: room_user.room)
      json = JSON.parse(V1::RoomSerializer.new(room_user.room).to_json)
      expect(json.keys.sort).to eq(
        ['capacity_limit', 'created_at', 'guid', 'host_user', 'name', 'participants', 'updated_at'].sort
      )
    end
  end
end
