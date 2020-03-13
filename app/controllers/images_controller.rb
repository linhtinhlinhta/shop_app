class ImagesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.create(image_params)
    redirect_to product_path(@product)
  end

  private
  def image_params
    params.require(:comment).permit(:image_url, :color)
  end
end

