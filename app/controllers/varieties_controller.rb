class VarietiesController < ApplicationController

  before_action :load_category

  def new
    @variety = Variety.new
  end

  def create
    @variety = @category.varieties.build(variety_params)
    if @variety.save
      redirect_to category_path(@category), notice: "The #{@variety.name} variety has been created."
    else
      flash.now[:alert] = "Variety could not be created."
      render :new
    end
  end

  def edit
    @variety = Variety.find(params[:id])
  end

  def update
    @variety = Variety.find(params[:id])
    success = @variety.update(variety_params)
    if success
      redirect_to category_variety_path(@variety.category_id, @variety.id), notice: "The #{@variety.name} variety has been updated."
    else
      flash.now[:alert] = "Variety could not be updated."
      render :new
    end
  end

  def show
    @variety = Variety.find(params[:id])
  end

  protected

  def variety_params
    params.require(:variety).permit(:name, :description)
  end

  def load_category
    @category = Category.find(params[:category_id])
  end

end
