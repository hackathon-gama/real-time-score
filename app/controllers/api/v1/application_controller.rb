# frozen_string_literal: true

class Api::V1::ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorize

  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token
    auth_header = request.headers['Authorization']

    return unless auth_header

    token = auth_header.split.last
    begin
      JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    decoded_token = decode_token

    return unless decoded_token

    user_id = decoded_token.first['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorize
    render json: { message: 'Please log in' }, status: :unauthorized unless current_user
  end
end
