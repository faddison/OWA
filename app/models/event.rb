class Event < ActiveRecord::Base
  belongs_to :program
  belongs_to :eventtype
  belongs_to :facility
  attr_accessible :date, :duration, :eventtype_id, :facility_id, :program_id, :title
  def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['event title','date','duration','eventtype name','facility name','program name']
			all.each do |f|
				csv << [f.title,f.date,f.duration,f.eventtype.name,f.facility.name,f.program.name]
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['title LIKE ? or duration LIKE ? or date LIKE ?', "%#{search}%","#{search}","#{search}"])
		else
			return find(:all)
		end
	end
end
