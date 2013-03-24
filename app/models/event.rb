class Event < ActiveRecord::Base
  belongs_to :program
  belongs_to :eventtype
  belongs_to :facility
  attr_accessible :date, :duration, :eventtype_id, :facility_id, :program_id, :title
  def self.to_csv(params)
		@records = Event.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << ['event name']
			@records.each do |f|
				csv << [f.name]
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
