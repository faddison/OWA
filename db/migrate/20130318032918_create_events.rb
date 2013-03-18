class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :date
      t.string :title
      t.integer :evettype_id
      t.references :eventype
      t.integer :facility_id
      t.references :facility
      t.integer :program_id
      t.references :program
      t.integer :duration
      t.string :notes

      t.timestamps
    end
    add_index :events, :eventype_id
    add_index :events, :facility_id
    add_index :events, :program_id
  end
end
