class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :name
      t.references :referrallog

      t.timestamps
    end
    add_index :referrals, :referrallog_id
  end
end
