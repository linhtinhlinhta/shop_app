class ApplicationController < ActionController::Base

  before_action :list_categories
  before_action :set_search
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
end
