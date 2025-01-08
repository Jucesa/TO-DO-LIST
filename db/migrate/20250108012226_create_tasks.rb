class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :titulo
      t.string :prioridade
      t.string :status
      t.integer :tempo_estimado
      t.string :descrição
      t.string :descrição
      t.date :data_inicio
      t.date :data_limite

      t.timestamps
    end
  end
end
