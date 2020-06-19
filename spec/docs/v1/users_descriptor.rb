module Docs
  module V1
    module UsersDescriptor
      extend Dox::DSL::Syntax

      document :api do
        resource 'Users' do
          endpoint '/v1/users'
          group 'Users'
        end
      end

      document :sign_in do
        action 'Sign in a user'
      end

      document :register do
        action 'Register a user'
      end

      document :index do
        action 'Get users'
      end

      document :update do
        action 'Update a user'
      end

      document :destroy do
        action 'Destroy a user'
      end
    end
  end
end
