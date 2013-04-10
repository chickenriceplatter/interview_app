class StudentsController < ApplicationController
  def new
    @student = Student.new(:user_id => current_user.object_id)
  end

  def create
    @student = Student.new(params[:student])
    @student.user_id = current_user.object_id
    # @student.email = current_user.email
    if @student.save
    redirect_to student_path(@student.id)
    else
      render 'new'
    end
  end

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @student_companies =Employer.companies_interested_in_student(@student.id)
    @student_interest = Employer.companies_student_has_interest(@student.id)
    @matches = Student.find_matches(@student_companies, @student_interest)
    @upcoming_interviews = Interview.upcoming_interviews(@student,current_user.role)

  end

  def edit
      if session[:user_id] == params[:id].to_i
      @student = Student.find(params[:id])
    else
      flash[:notice] = "Not Authorized!"
      redirect_to students_path
    end
    
  end
  
  def update
    if session[:user_id] == params[:id].to_i
      @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      redirect_to action: :show, id: @student.id
    else
      render 'edit'
    end
    else
      flash[:notice] = "Not Authorized!"
      redirect_to students_path
    end


  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to root_path
  end


end
