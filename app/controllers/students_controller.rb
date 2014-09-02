class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash.notice = "Student created"
      redirect_to root_path
    else
      flash.now[:alert] = "Student could not be created"
      render :new
    end
  end

  def call_on
    random_student = Student.all.sample
    flash.notice = "#{random_student.name} was chosen!"
    random_student.save
    redirect_to root_path
  end

  protected

  def student_params
    params.require(:student).permit(:name, :called_on)
  end
end
