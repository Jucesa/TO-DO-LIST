class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :priority
      t.float :estimated_time
      t.date :start_date
      t.date :end_date
      t.string :details

      t.timestamps
    end
  end
end
