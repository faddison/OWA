class ChangeEventTitleToName < ActiveRecord::Migration
  def change
    rename_column :Events, :title, :name
  end
end
