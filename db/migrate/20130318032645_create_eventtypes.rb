class CreateEventtypes < ActiveRecord::Migration
  def change
    create_table :eventtypes do |t|
      t.string :name
      t.string  :status
      t.timestamps
    end
  end
end
