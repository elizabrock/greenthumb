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
      flash.alert = "Category could not be created."
      render :new
    end
  end

  protected

  def category_params
    params.require(:category).permit(:name, :edible)
  end
end
