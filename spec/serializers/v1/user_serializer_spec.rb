require 'rails_helper'

describe V1::UserSerializer do
  describe 'application user' do
    it 'includes the expected attributes' do
      user = build_stubbed(:user)
      json = JSON.parse(V1::UserSerializer.new(user).to_json)
      expect(json.keys.sort).to eq(
        ['id', 'username', 'mobile_token', 'created_at', 'updated_at'].sort
      )
    end
  end
end
