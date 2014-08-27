class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "The #{@category.name} category has been created."
    else
      flash.now[:alert] = "Category could not be created."
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "The #{@category.name} category has been updated."
    else
      flash.now[:alert] = "Name can't be blank"
      render :edit
    end
  end

  protected

  def category_params
    params.require(:category).permit(:name, :edible)
  end
end
