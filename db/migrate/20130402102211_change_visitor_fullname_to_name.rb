class ChangeVisitorFullnameToName < ActiveRecord::Migration
  def change
    rename_column :Visitors, :fullname, :name
  end
end
