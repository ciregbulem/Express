class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy]
  layout 'employer'
  
  def index
    @employers = Employer.all
  end
  
  def show
    @employer = Employer.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_employer
      @employer = Employer.find(params[:id])
    end
  
    def employer_params
      params[:employer].permit(:company, :position, :grad_year)
    end
end

