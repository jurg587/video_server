class AuthorizeRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user = User.find_by(id: decoded_auth_token[:user_id]) if decoded_auth_token
    raise CustomExceptions::Authentication.new 'Invalid Authentication Token' if @user.blank?
    @user
  end

  def decoded_auth_token
    raise CustomExceptions::Authentication.new 'Missing Token' unless headers['Authorization'].present?
    @decoded_auth_token ||= AuthTokenService.decode(headers['Authorization'].split(' ').last)
  end
end
