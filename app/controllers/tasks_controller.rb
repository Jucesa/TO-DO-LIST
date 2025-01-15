class TasksController < ApplicationController
  before_action :set_user
  before_action :set_list, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :set_task, only: [:edit, :update, :destroy, :show]
  def index 
    @tasks = Task.all
  end
  
  def new
    @task = @list.tasks.build
    render turbo_stream: turbo_stream.replace("modal", partial: "tasks/form", locals: { task: @task, user: @user, list: @list })
  end

  def create
    @task = @list.tasks.build(task_params)
    if @task.save
      render turbo_stream: turbo_stream.append("list-#{@task.list_id}-tasks", partial: "tasks/task", locals: { task: @task })
    else
      render turbo_stream: turbo_stream.replace("modal", partial: "tasks/form", locals: { task: @task, user: @user, list: @list }), status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
    @list = List.find(params[:list_id]) 
    @user = User.find(params[:user_id])
    render turbo_stream: turbo_stream.replace("modal", partial: "tasks/form", locals: { task: @task })
  end
  
  def update
    if @task.update(task_params)
      render json: { success: true }
    else
      render json: { success: false, errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_list
    @task = Task.find(params[:id])
    if @task.update(list_id: params[:list_id])
      render json: { message: "Task updated successfully", task: @task }, status: :ok
    else
      render json: { error: "Failed to update task" }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render turbo_stream: turbo_stream.remove("task-#{@task.id}")
  end
  

  def show
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    render turbo_stream: turbo_stream.replace(
      "modal",
      partial: "tasks/task",
      locals: { task: @task, user: @user, list: @list }
    )
  end
  
  private

  def set_user
    @user = current_user
  end

  def set_list
    @list = @user.lists.find(params[:list_id])
  end

  def set_task
    @task = @list.tasks.find_by(id: params[:id])
    unless @task
      redirect_to user_list_path(@user, @list), alert: 'Task not found.'
    end
  end

  def task_params
    params.require(:task).permit(:name, :priority, :estimated_time, :start_date, :end_date, :details, :list_id)
  end  
end