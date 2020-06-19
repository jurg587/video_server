class Room < ApplicationRecord
  # Define associations
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  # Always set a new guid before a room is created
  before_validation :set_guid

  # Find the current host user for the room.
  def host_user
    users.joins(:room_users).where(room_users: { is_host: true}).last
  end

  # Find the new room user host. Ensure that the new host is a participant. Remove the current host and set the new host.
  def change_host(host_user)
    new_host_user = room_users.find_by(user: host_user)
    raise ActiveRecord::RecordNotFound.new 'New Host is not a participant' if new_host_user.blank?
    room_users.where(is_host: true).update_all(is_host: false)
    new_host_user.update(is_host: true)
  end

  private

  # Set the guid if it is not set yet.
  def set_guid
    self.guid = SecureRandom.uuid if self.guid.nil?
  end
end
