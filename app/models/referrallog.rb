class Referrallog < ActiveRecord::Base
  belongs_to :referral
  belongs_to :facility
  attr_accessible :count, :date, :facility_id, :referral_id, :fname, :rname
  def self.to_csv(params)
		@records = Eventtype.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << ['event name']
			@records.each do |f|
				csv << [f.name]
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
