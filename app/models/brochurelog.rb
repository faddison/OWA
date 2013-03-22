class Brochurelog < ActiveRecord::Base
  belongs_to :facility	
  belongs_to :brochure
  attr_accessible :brochure_id, :count, :date, :facility_id
  def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['facility_id','facility name','brochure_id','brochure name']
			all.each do |f|
				csv << [f.facility.id,f.facility.name,f.brochure.id,f.brochure.name]
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['date LIKE ? or count LIKE ? or facility_id LIKE ? or brochure_id LIKE ?', "%#{search}%","#{search}","#{search}","#{search}"])
		else
			return Brochurelog.all
		end
	end
	
  
end
