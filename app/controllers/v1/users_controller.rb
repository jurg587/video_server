class V1::UsersController < V1::ApplicationController
  # Skip authentication for the sign_in, register and index call
  skip_before_action :authenticate_request, only: [:sign_in, :register, :index]

  # Find the user based on the username. validate the password provided. return an auth token as part of the json response.
  def sign_in
    user = User.find_by(username: params[:username])
    raise CustomExceptions::Authentication.new 'Invalid Credentials' unless user && user.authenticate(params[:password])
    user.auth_token = AuthTokenService.encode({user_id: user.id})
    render_show user
  end

  # Initialise a new user object with the user params. save the user and return an auth token as part of the json response.
  def register
    user = User.new(user_params)
    user.save!
    user.auth_token = AuthTokenService.encode({user_id: user.id})
    render_create user
  end

  # Return all users with an optional username filter.
  def index
    render_index find_users
  end

  # Ensure that the current_user can only update their own user object.
  def update
    current_user.update(user_update_params)
    render_update current_user
  end

  # Ensure that the current_user can only delete their own user object.
  def destroy
    current_user.destroy
    render_destroy current_user
  end

  private

  # Find all users if no username param is set. Find all users given a certain username if the username params is set.
  def find_users
    User.by_username(params[:username])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :mobile_token)
  end

  # Allow the user to update their password and mobile token only
  def user_update_params
    params.require(:user).permit(:password, :password_confirmation, :mobile_token)
  end
end
