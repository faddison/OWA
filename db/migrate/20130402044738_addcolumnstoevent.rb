class Addcolumnstoevent < ActiveRecord::Migration
  def change
    add_column :events, :pname, :string
		add_column :events, :fname, :string
		add_column :events, :etname, :string
  end
end
