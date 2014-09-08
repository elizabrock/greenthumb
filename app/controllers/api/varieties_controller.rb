class Api::VarietiesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    respond_to do |format|
      if @category.varieties.count < 1
        format.html { render html: "<p>No varieties exist</p>" }
      else
        format.html { render partial: "varieties" }
      end
    end
  end
end
