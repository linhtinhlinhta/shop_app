class ApplicationController < ActionController::Base
  before_action :list_categories
  before_action :set_search
  protect_from_forgery with: :exception

  def list_categories
    @categories = Category.all
  end

  def set_search
    @q=Product.search(params[:q])
  end
end
