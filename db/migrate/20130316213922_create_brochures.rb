class CreateBrochures < ActiveRecord::Migration
  def change
    create_table :brochures do |t|
      t.string :name

      t.timestamps
    end
  end
end