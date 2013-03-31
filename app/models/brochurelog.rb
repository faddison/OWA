
class Brochurelog < ActiveRecord::Base
  belongs_to :facility	
  belongs_to :brochure
  attr_accessible :brochure_id, :count, :date, :facility_id, :bname,:fname,:status
  
  def self.to_csv(params)
		@records = Brochurelog.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
	def self.connfinal
		establish_connection('development')
	end
	def self.conndeve
		establish_connection('development')
	end
  
end
