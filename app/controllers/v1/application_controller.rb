class V1::ApplicationController < ActionController::API
  # Use the pundit gem with policies to check permissions
  include Pundit

  # Authenticate all requests. This is skipped in each controller if authentication should be skipped.
  before_action :authenticate_request
  attr_reader :current_user

  # Handle exceptions globally for any api call
  rescue_from RuntimeError, with: :runtime_error_rescue
  rescue_from CustomExceptions::Authentication, with: :not_authenticated_rescue
  rescue_from CustomExceptions::Authorization, Pundit::NotAuthorizedError, with: :not_authorized_rescue
  rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, with: :unprocessable_entity_rescue

  # Used to render a collection of data
  def render_index(objects)
    serializer = serializer(objects.first)
    render json: objects, each_serializer: serializer, adapter: :json, status: :ok
  end

  # Used to render an object for a get call
  def render_show(object)
    serializer = serializer(object)
    render json: object, serializer: serializer, adapter: :json, status: :ok
  end

  # Used to render any update call
  def render_update(object)
    if object.valid?
      serializer = serializer(object)
      render json: object, serializer: serializer, adapter: :json, status: :ok
    else
      render json: object.errors, status: :unprocessable_entity
    end
  end

  # Used to render any create call
  def render_create(object, arg = nil)
    if object.valid?
      yield(arg) if block_given?
      serializer = serializer(object)
      render json: object, serializer: serializer, adapter: :json, status: :created
    else
      render json: object.errors, status: :unprocessable_entity
    end
  end

  # Used to render any destroy call
  def render_destroy(object)
    render json: {}, status: :no_content
  end

  # Render relevant responses based on the exception raised
  def runtime_error_rescue(exception)
    logger.fatal("#{exception.class}: " + exception.message)
    render json: { error: exception.message }, status: :internal_server_error
  end

  def not_authorized_rescue(exception)
    logger.info("#{exception.class}: " + exception.message)
    render json: { error: exception.message }, status: :forbidden
  end

  def not_authenticated_rescue(exception)
    logger.info("#{exception.class}: " + exception.errors)
    render json: { error: exception.errors }, status: :unauthorized
  end

  def unprocessable_entity_rescue(exception)
    logger.info("#{exception.class}: " + exception.message)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  private

  # Set the current user globally so that it is accessible in controllers
  def authenticate_request
    @current_user = AuthorizeRequest.call(request.headers).result
  end

  # Find the serializer class dynamically based on the model object.
  def serializer(model)
    return V1::ApplicationSerializer if model.blank?
    serializer_name = "V1::#{model.class.to_s.camelize}Serializer"
    Object.const_defined?(serializer_name) ? serializer_name.constantize : nil
  end
end


