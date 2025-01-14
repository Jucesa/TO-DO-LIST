json.extract! task, :id, :name, :priority, :estimated_time, :start_date, :end_date, :details, :created_at, :updated_at
json.url task_url(task, format: :json)
