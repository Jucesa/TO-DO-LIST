class AddUserToFolders < ActiveRecord::Migration[8.0]
  def change
    add_reference :pasta, :user, null: false, foreign_key: true
    add_reference :lista, :user, null: false, foreign_key: true
  end
end
