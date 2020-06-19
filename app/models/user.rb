class User < ApplicationRecord
  # Define associations
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  # Use secure password so that a user has to authenticate with a password. They must also confirm the password upon registration.
  has_secure_password

  attr_accessor :auth_token

  validates :username, presence: true

  # Filter users if a username is provided. Return all users if the username is not set.
  scope :by_username, -> (username) { username.blank? ? all : where('username LIKE ?', "%#{sanitize_sql_like(username)}%") }

  # Check if the user is the host if a given room.
  def is_host?(room)
    room_users.find_by(room_id: room.id, is_host: true).present?
  end
end
