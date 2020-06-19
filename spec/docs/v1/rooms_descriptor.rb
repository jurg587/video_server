module Docs
  module V1
    module RoomsDescriptor
      extend Dox::DSL::Syntax

      document :api do
        resource 'Rooms' do
          endpoint '/v1/rooms'
          group 'Rooms'
        end
      end

      document :show do
        action 'Get room'
      end

      document :create do
        action 'Create a room'
      end

      document :change_host do
        action 'Change the room host'
      end

      document :join do
        action 'Join a room'
      end

      document :leave do
        action 'Leave a room'
      end

      document :search do
        action 'Search rooms given a username'
      end
    end
  end
end
