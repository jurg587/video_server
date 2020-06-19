class RoomUser < ApplicationRecord
  # Define associations
  belongs_to :room
  belongs_to :user

  # Ensure that a user can only join a room once
  validates :room_id, uniqueness: { scope: :user_id }

end
