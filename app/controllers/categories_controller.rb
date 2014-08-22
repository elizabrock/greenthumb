class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new

  end

  def create
    category = Category.create!(category_params)
    redirect_to categories_path, notice: "The #{category.name} category has been created."
  end

  protected

  def category_params
    params.require(:category).permit(:name, :edible)
  end
end
