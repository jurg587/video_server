class V1::RoomsController < V1::ApplicationController
  # Skip authentication for the show call
  skip_before_action :authenticate_request, only: [:show]

  def show
    room = find_room
    render_show room
  end

  def create
    room = Room.new(room_params)
    room.room_users.new(user: current_user)
    room.save!
    render_create room
  end

  # Find the room based on a guid. Authorise the user to see if they are the host. Ensure that the new host user exists before changing the host.
  def change_host
    room = find_room
    authorize room
    new_host_user = User.find(change_host_params[:host_user_id])
    room.change_host(new_host_user)
    render_update room
  end

  # Find the room based on a guid. Create a room user to associate the user with the room. This will fail if the user is already in the room.
  def join
    room = find_room
    room_user = RoomUser.new(room: room, user: current_user, is_host: false)
    room_user.save!
    render_show room
  end

  # Find the room based on a guid. Ensure that the user is not the host. If the user is not the host leave the room by destroying the association.
  def leave
    room = find_room
    room_user = current_user.room_users.find_by(room: room)
    raise CustomExceptions::Authorization if room_user.is_host
    room_user.destroy
    render_destroy room
  end

  # Find a user based on a username. Return the rooms for that user.
  def search
    user = find_user
    rooms = user.rooms
    render_index rooms
  end

  private

  # Find a room and ensure the room exist before continuing.
  def find_room
    room = Room.find_by(guid: params[:guid])
    raise ActiveRecord::RecordNotFound.new 'Room not found' if room.blank?
    room
  end

  # Get all rooms based on a username. If the username param is blank then it returns all rooms
  def find_rooms
    Room.by_search_params(params[:username])
  end

  # Find a user based on a username. Ensure the user exists before continuing.
  def find_user
    user = User.find_by(username: params[:username])
    raise ActiveRecord::RecordNotFound.new 'User with the given username does not exist' if user.blank?
    user
  end

  # Permit the name and capacity limit field as params only
  def room_params
    params.require(:room).permit(:name, :capacity_limit)
  end

  # Only permit the new host user id when a host wants to change the host
  def change_host_params
    params.require(:room).permit(:host_user_id)
  end
end
