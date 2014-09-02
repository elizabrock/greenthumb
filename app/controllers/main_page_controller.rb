class MainPageController < ApplicationController
  def index
    @students = Student.all
  end
end
