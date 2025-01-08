class TasksController < ApplicationController
    def new
        @tasks = Task.where(user_id: current_user.id) # Adjust the query as needed
    end
    
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        head :ok
      else
        head :unprocessable_entity
      end
    end
  
    private
  
    def task_params
      params.require(:task).permit(:status)
    end
  end