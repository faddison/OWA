class CreateReferrallogs < ActiveRecord::Migration
  def change
    create_table :referrallogs do |t|
      t.string :date
      t.integer :count
      t.references :facility

      t.timestamps
    end
    add_index :referrallogs, :facility_id
  end
end
