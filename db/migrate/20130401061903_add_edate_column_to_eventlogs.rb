class AddEdateColumnToEventlogs < ActiveRecord::Migration
  def change
    add_column :eventlogs, :edate, :date
  end
end
