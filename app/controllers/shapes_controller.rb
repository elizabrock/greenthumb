class ShapesController < ApplicationController

  def create
    @garden = Garden.find(params[:garden_id])
    shape = @garden.shapes.build(shape_params)
    shape.save!

    respond_to do |format|
      format.json { render json: { message: "Your garden was saved!" }}
    end
  end

  protected

  def shape_params
    params.require(:shape).permit(:height, :width, :top, :left, :color, :type)
  end
end
