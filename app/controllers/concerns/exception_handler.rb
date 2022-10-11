# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class HTTPOK < StandardError; end

  included do
    rescue_from AuthenticationError, with: :unauthorized_request
    rescue_from MissingToken, with: :unauthorized_request
    rescue_from InvalidToken, with: :unauthorized_request

    rescue_from ActionController::ParameterMissing do |e|
      render json: { message: "'#{e.param}' is missing" }, status: :bad_request
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message, errors: e.record.errors },
        status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      Rails.logger.error(e.message)
      render json: { message: 'record already registered' }, status: :method_not_allowed
    end

    rescue_from ActiveRecord::RecordNotDestroyed do |e|
      render json: { message: e.message, errors: e.record.errors },
        status: :method_not_allowed
    end

    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { message: 'the record does not exist or has been deleted' },
        status: :not_found
    end

    rescue_from ActionDispatch::Http::Parameters::ParseError do |_e|
      Rails.logger.error(e.message)
      render json: { message: 'the payload sent is not valid' }, status: :bad_request
    end

    rescue_from HTTPOK do |e|
      render json: { message: e.message }, status: :ok
    end
  end

  private

  def unauthorized_request(exception)
    render json: { message: exception.message }, status: :unauthorized
  end
end
