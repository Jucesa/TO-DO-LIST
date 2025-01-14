class ListsController < ApplicationController
  before_action :set_user
  before_action :set_list, only: [:destroy]

  def index
    @lists = @user.lists
  end

  def show
    @list = @user.lists.find(params[:id])
  end

  def new
    @list = @user.lists.build
  end

  def create
    @list = @user.lists.build(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to user_path(@user), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def task_list
    # Ensure only tasks belonging to the current user's lists are fetched
    @tasks = Task.joins(:list).where(lists: { user_id: current_user.id })
    
    # Render JSON in FullCalendar-compatible format
    render json: @tasks.map do |task|
      {
        id: task.id,
        title: task.titulo,               # Use 'titulo' for the event title
        start: task.data_inicio&.iso8601, # Map 'data_inicio' to FullCalendar's 'start'
        end: task.data_limite&.iso8601,   # Map 'data_limite' to FullCalendar's 'end'
        allDay: false,                    # Assuming tasks are not all-day events
        list_id: task.lista_id            # Include list ID for reference
      }
    end
  end

  def show_tasks
    @tasks = Task.joins(:list).where(lists: { user_id: current_user.id })
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: "List was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end