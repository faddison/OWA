class CreateBrochures < ActiveRecord::Migration
  def change
    create_table :brochures do |t|
      t.string :name
      t.references :brochurelog

      t.timestamps
    end
    add_index :brochures, :brochurelog_id
  end
end
