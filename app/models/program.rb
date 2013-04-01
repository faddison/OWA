
class Program < ActiveRecord::Base
  attr_accessible :name,:status
  validates :name,  :presence => true
  def self.to_csv(params)
		@records = Program.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
 
	
  
  
end
