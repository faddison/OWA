class CreateBrochurelogs < ActiveRecord::Migration
  def change
    create_table :brochurelogs do |t|
      t.string :date
      t.integer :count
      t.references :facility
      t.integer :facility_id
      t.integer :brochure_id
      t.references :brochure
	  t.string	:bname
	  t.string	:fname
      t.timestamps
    end
    add_index :brochurelogs, :facility_id
    add_index :brochurelogs, :brochure_id
  end
end
