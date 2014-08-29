class ShapesController < ApplicationController

  def create
    if params[:type] == "circle"
      @circle = Circle.create!(height: params[:height], width: params[:width], top: params[:top], left: params[:left], color: params[:color], garden_id: params[:garden_id])
    elsif params[:type] == "rectangle"
      @rectangle = Rectangle.create!(height: params[:height], width: params[:width], top: params[:top], left: params[:left], color: params[:color], garden_id: params[:garden_id])
    end

    respond_to do |format|
      format.json { render json: { message: "Your garden was saved!" }}
    end
  end


end