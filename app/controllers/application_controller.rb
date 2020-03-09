class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :list_categories
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  HOME_PAGINATES_PER = 8
  CATEGORY_PAGINATES_PER = 9

  def list_categories
    @categories = Category.all
  end

  private
  def set_search
    @q=Product.search(params[:q])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:avatar, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password)}
  end
end

