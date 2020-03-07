class ApplicationController < ActionController::Base
  before_action :list_categories
  protect_from_forgery with: :exception

  def list_categories
    @categories = Category.all
  end
end
