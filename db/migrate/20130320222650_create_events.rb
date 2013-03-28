class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.references :program
      t.integer :program_id
      t.references :eventtype
      t.integer :eventtype_id
      t.references :facility
      t.integer :facility_id
      t.integer :duration
	  t.string  :status
      t.date :date

      t.timestamps
    end
    add_index :events, :program_id
    add_index :events, :eventtype_id
    add_index :events, :facility_id
  end
end
