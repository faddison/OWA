class ChangeEventlogEdateToDate < ActiveRecord::Migration
  def change
    rename_column :Eventlogs, :edate, :date
  end
end
