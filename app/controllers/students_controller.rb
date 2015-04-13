class StudentsController < ApplicationController
  before_action :set_student
  
  def index
    @students=Student.all
  end
  
  def show
    @student=Student.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_student
      @student=Student.find(params[:id])
    end
  
    def student_params
      params[:student].permit(:street_address, :city, :state, :zip, :cell_number, :home_number, :gpa, :skill, :experience, :major, :minor, :grad_year, :leadership, :sport)
    end
end
