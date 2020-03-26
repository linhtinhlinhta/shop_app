class Admin::ProductsController < ApplicationController
  layout 'admin'

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      UpdateProductJob.perform_later(@product)
      redirect_to admin_products_path
    end
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
    UpdateProductJob.perform_later(@product.id)
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    redirect_to admin_products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :code, :description, :category_id)
  end
end
