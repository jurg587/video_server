class V1::RoomSerializer < V1::ApplicationSerializer
  # Define the json attributes to serialize
  attributes :name, :guid, :capacity_limit, :host_user, :participants, :created_at, :updated_at

  # serialize the host user object
  def host_user
    host_user = {}
    host_user = V1::UserSerializer.new(object.host_user, root: false) if object.host_user.present?
    host_user
  end

  # serialize all room users as participants
  def participants
    object.users.map do |user|
      V1::UserSerializer.new(user, root: false)
    end
  end
end
