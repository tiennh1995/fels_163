class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  include CanCan::ControllerAdditions
  include PublicActivity::StoreController

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "not_authorized"
    redirect_to root_url
  end

  def after_sign_in_path_for resource
    current_user.try(:is_admin?) ? admin_root_path : root_path
  end

  private
  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new current_user, controller_namespace
  end
end
