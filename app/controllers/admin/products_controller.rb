class Admin::ProductsController < ApplicationController
  layout 'admin'

  def index
    @products = Product.all
  end

  def create
    @product = Product.create(product_params)
    redirect_to admin_products_path
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    redirect_to admin_products_path
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      @products = @category.products.destroy
    end
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end
end
