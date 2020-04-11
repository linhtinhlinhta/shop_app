class Admin::CategoriesController < AdminController
  layout 'admin'

  def index
    @categories = Category.all
  end

  def create
    @category = Category.create(category_params)
    redirect_to admin_categories_path
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path
    else
      flash[:error] = "Failed to edit category!"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
