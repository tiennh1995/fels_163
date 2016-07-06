class SessionsController < Devise::SessionsController
  before_action :create_log, only: :destroy
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  private
  def create_log
    if current_user.is_admin?
      current_user.logs.create(
        current_sign_in_ip: current_user.current_sign_in_ip,
        last_sign_in_ip: current_user.last_sign_in_ip,
        current_sign_in_at: current_user.current_sign_in_at,
        last_sign_in_at: current_user.last_sign_in_at)
    end
  end
end
