# frozen_string_literal: true

class Api::V1::ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthenticationHandler

  before_action :authorize
end
