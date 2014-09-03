class ShapesController < ApplicationController

  def create
    @garden = Garden.find(params[:garden_id])
    @garden.circles.create!(circle_params)

    respond_to do |format|
      format.json { render json: { message: "Your garden was saved!" }}
    end
  end

  protected

  def circle_params
    params.require(:circle).permit(:height, :width, :top, :left, :color)
  end
end
