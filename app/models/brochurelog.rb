class Brochurelog < ActiveRecord::Base
  belongs_to :facility	
  belongs_to :brochure
  attr_accessible :brochure_id, :count, :date, :facility_id, :bname,:fname
  def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['facility_id','facility name','brochure_id','brochure name','count']
			all.each do |f|
				csv << [f.facility.id,f.facility.name,f.brochure.id,f.brochure.name,f.count]
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['date LIKE ? or count LIKE ? or bname LIKE ? or fname LIKE ?', "%#{search}%","#{search}","#{search}","#{search}"])
		else
			return Brochurelog.all
		end
	end
	
  
end
