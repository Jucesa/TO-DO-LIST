class ListController < ApplicationController
    def index
      @listas = Lista.all || []
      @tasks = Task.joins(:list).where(lists: { user_id: current_user.id })
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
      
  end
  
  