class AddUniqueIndexToBrochurelogs < ActiveRecord::Migration
  def change
	add_index :brochurelogs, [:date, :facility_id, :brochure_id], :unique => true
  end
end
