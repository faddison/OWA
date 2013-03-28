class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :fname
      t.string :lname
      t.string :language
      t.string :email
      t.string :phone
	  t.string :fullname
	  t.string :country
	  t.string :postcode
	  t.string :husband
	  t.string :notes
	  t.date :ftime
	  t.string :status
      t.timestamps
    end
  end
end