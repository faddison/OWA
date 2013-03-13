class CreateBrochurelogs < ActiveRecord::Migration
  def change
    create_table :brochurelogs do |t|
      t.string :date
      t.integer :count
      t.references :facility

      t.timestamps
    end
    add_index :brochurelogs, :facility_id
  end
end
