class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :devise_add_params, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['FURIMA_AUTH_USER'] && password == ENV['FURIMA_AUTH_PASSWORD']
    end
  end

  def devise_add_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nickname, :family_name, :given_name, :family_reading, :given_reading, :birthday ])
  end
end
