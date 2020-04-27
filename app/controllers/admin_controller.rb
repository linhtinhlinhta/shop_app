class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def dashboard
  end

  private
  def authenticate_admin!
    redirect_to root_path, notice: "Sorry! You're not admin." unless current_user.admin?
  end

end
