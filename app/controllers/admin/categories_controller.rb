class Admin::CategoriesController < Admin::AdminController
  before_action :correct_supervisor, only: [:edit, :update, :index, :show, :new]
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Create a new category successfully!"
      redirect_to admin_categories_path
    else
      flash[:danger] = "Invalid category!"
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:success]= "Category updated"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit :cat_name, :icon, :description
  end
end
