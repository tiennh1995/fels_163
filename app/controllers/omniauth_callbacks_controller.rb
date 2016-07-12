class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %w(facebook twitter).each do |provider|
    define_method provider do
      @identity = Identity.find_for_oauth env["omniauth.auth"]
      @user = @identity.user || current_user
      if @identity.provider == "twitter"
        nickname = env["omniauth.auth"].info.nickname.gsub(/[^0-9A-Za-z]/, "")
        @identity.email = "#{nickname}@fels.xxx"
      end
      @user ||= User.find_by email: @identity.email
      @user ||= User.create name: @identity.name, email: @identity.email,
        password: @identity.uid, password_confirmation: @identity.uid,
        image: @identity.image
      if @user.persisted?
        @identity.update_attributes user_id: @user.id
        sign_in_and_redirect @user, event: :authentication
        set_flash_message :notice, :success,
          kind: provider.capitalize if is_navigational_format?
      else
        redirect_to new_user_session
      end
    end
  end
end
