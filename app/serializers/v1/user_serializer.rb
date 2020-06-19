class V1::UserSerializer < V1::ApplicationSerializer
  # Define the json attributes to serialize
  attributes :id, :username, :mobile_token, :created_at, :updated_at
  attribute :auth_token, if: -> { object.auth_token.present? }

  # Serialize the auth_token for sign in and register.
  def auth_token
    object.auth_token
  end
end
