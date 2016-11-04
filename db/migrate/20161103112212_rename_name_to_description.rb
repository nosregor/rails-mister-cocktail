class RenameNameToDescription < ActiveRecord::Migration[5.0]
  def change
    rename_column :doses, :name, :description
  end
end
