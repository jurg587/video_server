require 'rails_helper'

RSpec.describe RoomPolicy do
  subject { described_class.new(user, record) }

  describe 'application permissions' do
    before :all do
      @room_user = create(:room_user, is_host: true)
    end

    let(:user) { @room_user.user }
    let(:record) { @room_user.room }
    it { is_expected.to permit_actions([:change_host]) }
  end
end
