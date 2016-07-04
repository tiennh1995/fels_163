class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit :email,
      :name, :password, :password_confirmation}
  end
end
