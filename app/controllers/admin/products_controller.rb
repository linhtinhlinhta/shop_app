class Admin::ProductsController < ApplicationController
  layout 'admin'

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      params[:images]['image_url'].each do |img|
        @image = @product.images.create!(:image_url => img)
      end
      UpdateProductJob.perform_later(@product)
      redirect_to admin_products_path
    end
  end

  def new
    @categories = Category.all
    @product = Product.new
    @image = @product.images.build
  end

  def edit
    @product = Product.find(params[:id])
    @images = @product.images.all
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images.all
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
    params.require(:product).permit(:name, :price, :code, :description, :category_id, images_attributes: [:image_url])
  end
end
