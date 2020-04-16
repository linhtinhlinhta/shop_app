class AdminController < ApplicationController
  before_action :authenticate_admin!

  private
  def authenticate_admin!
    return redirect_to new_user_session_path unless current_user
    sign_out(current_user) && (redirect_to new_user_session_path) unless current_user.has_role? :admin
  end
end
