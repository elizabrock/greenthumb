class VarietiesController < ApplicationController

  def new
    @variety = Variety.new
    @category = Category.find(params[:category_id])
  end

  def create
    @variety = Variety.new(variety_params)
    if @variety.save
      redirect_to category_path(), notice: "The #{@variety.name} variety has been created."
    else
      flash.alert = "Variety could not be created."
      render :new
    end
  end

  protected

  def variety_params
    params.require(:variety).permit(:name, :description)
  end

end
