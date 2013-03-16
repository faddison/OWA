class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
      t.integer :logid
      t.integer :rlogid

      t.timestamps
    end
  end
end
