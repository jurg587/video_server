require 'rails_helper'

RSpec.describe V1::RoomsController, type: :controller do
  include Docs::V1::RoomsDescriptor::Api

  describe 'routes' do
    it { should route(:get, 'v1/rooms/61459577-f398-4084-b146-3060acab6b1d').to(action: :show, guid: '61459577-f398-4084-b146-3060acab6b1d') }
    it { should route(:get, 'v1/rooms/search').to(action: :search) }
    it { should route(:post, 'v1/rooms').to(action: :create) }
    it { should route(:post, 'v1/rooms/join').to(action: :join) }
    it { should route(:delete, 'v1/rooms/leave').to(action: :leave) }
    it { should route(:put, 'v1/rooms/change_host').to(action: :change_host) }
  end

  describe 'show' do
    include Docs::V1::RoomsDescriptor::Show
    it 'gets a room given its guid', :dox do
      room_user = create(:room_user, is_host: true)
      params = { guid: room_user.room.guid }
      get :show, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['room']['guid']).to eq(room_user.room.guid)
    end
  end

  describe 'create' do
    include Docs::V1::RoomsDescriptor::Create
    it 'creates a new room for the current user', :dox do
      user = create(:user)
      params = { room: attributes_for(:room) }
      params[:room][:capacity_limit] = 20
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      post :create, params: params
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['room']['guid'].blank?).to eq(false)
      expect(json_response['room']['capacity_limit']).to eq(20)
    end

    it 'fails to create if a user is not authenticated' do
      params = { room: attributes_for(:room) }
      params[:room][:capacity_limit] = 20
      post :create, params: params
      expect(response).to have_http_status(401)
    end
  end

  describe 'change_host' do
    include Docs::V1::RoomsDescriptor::ChangeHost
    it 'changes the host of the room successfully if the current user is the host', :dox do
      host_room_user = create(:room_user, is_host: true)
      room_user = create(:room_user, room: host_room_user.room)
      user = host_room_user.user
      params = { room: { host_user_id: room_user.user.id }, guid: room_user.room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      put :change_host, params: params
      expect(response).to have_http_status(:ok)
      host_room_user.reload
      room_user.reload
      expect(host_room_user.is_host).to eq(false)
      expect(room_user.is_host).to eq(true)
    end

    it 'fails to change the host of the room if the current user is not the host' do
      host_room_user = create(:room_user)
      room_user = create(:room_user, room: host_room_user.room)
      user = host_room_user.user
      params = { room: { host_user_id: room_user.user.id }, guid: room_user.room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      put :change_host, params: params
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'join' do
    include Docs::V1::RoomsDescriptor::Join
    it 'joins a room successfully', :dox do
      user = create(:user)
      room = create(:room_user, is_host: true).room
      params = { guid: room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      post :join, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['room']['guid']).to eq(room.guid)
    end

    it 'fails to join a room if the user is already in the room' do
      room_user = create(:room_user)
      user = room_user.user
      room = room_user.room
      params = { guid: room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      post :join, params: params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'leave' do
    include Docs::V1::RoomsDescriptor::Leave
    it 'leaves a room successfully', :dox do
      room_user = create(:room_user)
      user = room_user.user
      params = { guid: room_user.room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      delete :leave, params: params
      expect(response).to have_http_status(:no_content)
      expect(response.body).to eq('{}')
    end

    it 'fails to leave a room if the current_user is the host' do
      room_user = create(:room_user, is_host: true)
      user = room_user.user
      params = { guid: room_user.room.guid }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      delete :leave, params: params
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'search' do
    include Docs::V1::RoomsDescriptor::Search
    it 'gets the user rooms given a certain username', :dox do
      room_user = create(:room_user, is_host: true)
      user = room_user.user
      create(:room_user, user: user, is_host: true)
      params = { username: user.username }
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      get :search, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['rooms'].length).to eq(2)
    end
  end
end
