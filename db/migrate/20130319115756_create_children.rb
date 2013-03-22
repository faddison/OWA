class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.references :visitor
	  t.string :allergies
	  
      t.timestamps
    end
    add_index :children, :visitor_id
  end
end
