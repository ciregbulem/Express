class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_student!, :except => [:index, :show, :update]
  layout 'student'
  
  def index
    @students = Student.all
  end
  
  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = current_student
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

  # GET/PATCH /students/:id/finish_signup
  def finish_signup
    current_student.email = current_student.temp_email
    # authorize! :update, @user 
    if request.patch? && params[:student] #&& params[:user][:email]
      if current_student.update(student_params)
        @student.skip_reconfirmation! if @student.respond_to?(:skip_confirmation)
        sign_in(current_student, :bypass => true)
        redirect_to current_student, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end
  
  private
    def set_student
      @student = Student.find(params[:id])
    end
  
    def student_params
      params[:student].permit(:street_address, :city, :state, :zip, :cell_number, :home_number, :gpa, :skill, :experience, :major, :minor, :grad_year, :leadership, :sport)
    end
end
