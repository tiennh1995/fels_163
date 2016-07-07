class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit :email,
      :name, :password, :password_confirmation}
  end

  def update_resource resource, params
    if resource.encrypted_password.blank?
      resource.email = params[:email] if params[:email]
      if params[:password].present? && params[:password] == params[:password_confirmation]
        resource.password = params[:password]
        resource.save
      end
      if resource.valid?
        resource.update_without_password params
      end
    else
      resource.update_with_password params
    end
  end
end
