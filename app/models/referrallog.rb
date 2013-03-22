class Referrallog < ActiveRecord::Base
  belongs_to :referral
  belongs_to :facility
  attr_accessible :count, :date, :facility_id, :referral_id, :fname, :rname
   def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['facility_id','facility name','referral_id','referral name','count']
			all.each do |f|
				csv << [f.facility.id,f.facility.name,f.referral.id,f.referral.name,f.count]
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['date LIKE ? or count LIKE ? or fname LIKE ? or rname ?', "%#{search}%","#{search}","#{search}","#{search}"])
		else
			return Referrallog.all
		end
	end
end
