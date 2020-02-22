class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == 'production'
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    # added_attrs = [:nickname, :email, :gender_id, :profession_id, :profile, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :gender_id, :profession_id, :profile])
    # devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :nickname, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :email, :gender_id, :profession_id, :profile])
    # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
