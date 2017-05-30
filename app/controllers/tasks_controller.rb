class TasksController < ApplicationController
  #before_action :set_task, only:[:edit, :update, :show, :destroy]


  def index
    @tasks =  current_user.tasks #Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(tasks_params)      #Task.new(tasks_params)
     if @task.save
       flash[:notice] = "Task was successfully created"
       redirect_to task_path(@task)
     else
       render 'new'
    end
  end

  def show
      @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Todo was successfully deleted"
    redirect_to tasks_path
  end


private

  # def set_task
  #   @task = Task.find(params[:id])
  # end

  def tasks_params
    params.require(:task).permit(:content, :state)
  end

end
