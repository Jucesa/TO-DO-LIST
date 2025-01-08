class CreatePasta < ActiveRecord::Migration[8.0]
  def change
    create_table :pasta do |t|
      t.string :titulo
      t.lista :listas, array: true, default: []

      t.timestamps
    end
  end
end
