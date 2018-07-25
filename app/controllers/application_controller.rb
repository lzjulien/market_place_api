class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  include Authenticable
  # def current_user
  #   @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  # end
end
