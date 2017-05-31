class TasksController < ApplicationController
  #before_action :set_task, only:[:edit, :update, :show, :destroy]


  def index
    #@tasks =  current_user.tasks #Task.all
    @to_do = current_user.tasks.where(state: 'to_do')
    @doing = current_user.tasks.where(state: 'doing')
    @done = current_user.tasks.where(state: 'done')
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(tasks_params)      
     if @task.save
       flash[:notice] = "Task was successfully created"
       redirect_to task_path(@task)
     else
       render 'new'
    end
  end

  def show
      @task = Task.find(params[:id])

      # Show data map      
      _latitude = '35.681298'
      _longitude = '139.7640529'
      _name = '東京駅'

      @hash = Gmaps4rails.build_markers(@task) do |place, marker|
        marker.lat _latitude
        marker.lng _longitude
        marker.infowindow _name
      end
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
    params.require(:task).permit(:content, :state, :image, :resource)
  end

end
