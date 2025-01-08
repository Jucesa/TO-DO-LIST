class AddFolderToLists < ActiveRecord::Migration[8.0]
  def change
    add_reference :lista, :pasta, null: false, foreign_key: true
  end
end
