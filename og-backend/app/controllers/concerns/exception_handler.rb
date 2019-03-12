module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  # define custom error subclasses -- rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    # define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :render_422
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :render_422
    rescue_from ExceptionHandler::InvalidToken, with: :render_422
    rescue_from ExceptionHandler::ExpiredSignature, with: :render_498
    rescue_from ExceptionHandler::DecodeError, with: :render_401

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end

  private

  def render_422(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def render_498(e)
    json_response({ message: e.message }, :invalid_token)
  end

  def render_401(e)
    json_response({ message: e.message }, :invalid_token)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
