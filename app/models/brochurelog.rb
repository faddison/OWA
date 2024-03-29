
class Brochurelog < ActiveRecord::Base
  belongs_to :facility	
  belongs_to :brochure
  attr_accessible :brochure_id, :count, :date, :facility_id, :bname,:fname,:status
  def self.to_csv(params)
		@records = Brochurelog.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['count LIKE ? or bname LIKE ? or fname LIKE ? or status LIKE ?', "%#{search}%","#{search}","#{search}","#{search}"])
		else
			return Brochurelog.all
		end
	end
	def self.connfinal
		establish_connection('finaldb')
	end
	def self.conndeve
		establish_connection('development')
	end
  
end
