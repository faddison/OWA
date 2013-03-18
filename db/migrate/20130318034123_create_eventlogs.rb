class CreateEventlogs < ActiveRecord::Migration
  def change
    create_table :eventlogs do |t|
      t.references :event
      t.integer :event_id
      t.references :person
      t.integer :person_id

      t.timestamps
    end
    add_index :eventlogs, :event_id
    add_index :eventlogs, :person_id
  end
end
