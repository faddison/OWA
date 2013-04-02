class CreateAbbreviations < ActiveRecord::Migration
  def change
    create_table :abbreviations do |t|
      t.string :word
      t.string :abbv

      t.timestamps
    end
  end
end
