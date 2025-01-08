class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashedPassword
      t.pasta :pastas, array: true, default: []
      t.lista :listas, array: true, default: []

      t.timestamps
    end
  end
end
