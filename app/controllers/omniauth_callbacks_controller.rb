class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %w(facebook twitter).each do |provider|
    define_method provider do
      @identity = Identity.find_for_oauth env["omniauth.auth"]
      @user = @identity.user || current_user
      if @user.nil?
        @user = User.find_or_create_by email: @identity.email
        @identity.update_attributes user_id: @user.id
      end
      if @user.email.blank? && @identity.email
        @user.update_attribute email: @identity.email
      end
      if @user.persisted?
        @identity.update_attributes user_id: @user.id
        sign_in_and_redirect @user, event: :authentication
        set_flash_message :notice, :success,
          kind: provider.capitalize if is_navigational_format?
      else
        session["devise.#{provider}_data"] = env["omniauth.auth"].except "extra"
        redirect_to new_user_registration_url
      end
    end
  end
end
