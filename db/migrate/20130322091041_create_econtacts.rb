class CreateEcontacts < ActiveRecord::Migration
  def change
    create_table :econtacts do |t|
      t.string :name
      t.string :phone
      t.string :relationship
      t.references :visitor

      t.timestamps
    end
    add_index :econtacts, :visitor_id
  end
end
