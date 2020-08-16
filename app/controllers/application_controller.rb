require 'rest-client'
require 'json'

class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload) # arg is data identifying user — e.g., DB id and username

    JWT.encode(payload, secret, algorithm)
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def secret
    Rails.application.secrets.secret_key_base
  end


  def algorithm
    'HS256'
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, secret, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    puts decoded_token
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  class AuthError < StandardError
    def initialize(message="Invalid User or password")
      super
    end
  end


  class RequestPasswordResetError < StandardError
    def initalize(message="Username not found. Please contact your ")
      super
    end
  end


  class CreateError < StandardError
    def initialize(message="Error - item not created")
      super
    end
  end
end
