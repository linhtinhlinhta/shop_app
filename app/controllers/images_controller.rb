class ImagesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.create(image_params)
    redirect_to product_path(@product)
  end

  private
  def image_params
    params.require(:image).permit(:image_url, :color, :remote_image_url_url)
  end
end
