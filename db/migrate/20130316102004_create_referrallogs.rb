class CreateReferrallogs < ActiveRecord::Migration
  def change
    create_table :referrallogs do |t|
      t.date :date
      t.integer :count
      t.integer :referral_id
      t.references :referral
      t.integer :facility_id
      t.references :facility
	  t.string	:fname
	  t.string	:rname
	  t.string  :status
      t.timestamps
    end
    add_index :referrallogs, :referral_id
    add_index :referrallogs, :facility_id
  end
end
