
class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
	  t.string  :status
      t.timestamps
    end
  end
end