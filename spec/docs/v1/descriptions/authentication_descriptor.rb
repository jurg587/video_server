module Docs
  module V1
    module AuthenticationDescriptor
      extend Dox::DSL::Syntax

      # define common resource data for each action
      document :api do
        resource 'Authentication' do
          endpoint '/authentication'
          group 'Authentication'
        end
      end

      document :re_authenticate do
        action 'Re-Authenticate'
      end
    end
  end
end
