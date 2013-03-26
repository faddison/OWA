class CreateEventlogs < ActiveRecord::Migration
  def change
    create_table :eventlogs do |t|
      t.references :event
      t.integer :event_id
      t.references :visitor
      t.integer :visitor_id
	  t.string :ename
	  t.string :vname
	  t.string  :status
      t.timestamps
    end
    add_index :eventlogs, :event_id
    add_index :eventlogs, :visitor_id
  end
end
