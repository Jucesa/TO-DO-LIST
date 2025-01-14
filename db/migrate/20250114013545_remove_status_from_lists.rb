class RemoveStatusFromLists < ActiveRecord::Migration[8.0]
  def change
    remove_column :lists, :status, :string
  end
end
