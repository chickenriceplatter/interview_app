class InterviewsController < ApplicationController
  def new
    @interview = Interview.new(params[:interview])
    @interview.interview_appts.build
    if current_user.id
      @student = Student.find(current_user.id)
    @upcoming_interviews = Interview.upcoming_interviews(@student)
    else
    end
  end

  def create
    @interview = Interview.new(params[:interview])
    if @interview.save
    redirect_to interview_path(@interview.id)
    else
      render 'new'
    end
  end

  def index
    @interviews = Interview.all
  end

  def show
    @interview = Interview.find(params[:id])
  end

  def edit
    @interview = Interview.find(params[:id])
  end
  
  def update
    @interview = Interview.find(params[:id])
    if @interview.update_attributes(params[:interview])
      redirect_to action: :show, id: @interview.id
    else
      render 'edit'
    end
  end
  
  def destroy
    @interview = Interview.find(params[:id])
    @interview.destroy
    redirect_to root_path
  end


end
