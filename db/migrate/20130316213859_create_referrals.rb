class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :name
	  t.string  :status
	  
      t.timestamps
    end
  end
end
