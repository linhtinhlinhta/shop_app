class Admin::ProductsController < AdminController
  layout 'admin'

  def index
    @products = Product.all.page(params[:page]).per(10)
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
    @image = @product.images.build
  end

  def edit
    @product = Product.find(params[:id])
    @images = @product.images.all
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to admin_products_path
    else
      render action: :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product)
          .permit(:name, :price, :code, :description,
                  images_attributes: Image.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
