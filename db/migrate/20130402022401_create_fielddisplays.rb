class CreateFielddisplays < ActiveRecord::Migration
  def change
    create_table :fielddisplays do |t|
      t.string :model
      t.string :field

      t.timestamps
    end
  end
end
