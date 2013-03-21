class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :fname
      t.string :lname
      t.string :language
      t.string :email
      t.string :phone
	  t.string :fullname
		
      t.timestamps
    end
  end
end
