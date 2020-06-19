class AuthenticateUser
  prepend SimpleCommand
  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    AuthTokenService.encode({user_id: user.id}) if user
  end

  private

  attr_accessor :username, :password

  def user
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)
    raise 'AuthenticationException'.new 'Invalid Credentials'
  end
end