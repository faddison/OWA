class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :fname
      t.string :lname
      t.string :language
      t.string :poop

      t.timestamps
    end
  end
end
