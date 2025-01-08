class CreateLista < ActiveRecord::Migration[8.0]
  def change
    create_table :lista do |t|
      t.string :titulo
      t.task :tasks, array: true, default: []
      
      t.timestamps
    end
  end
end
