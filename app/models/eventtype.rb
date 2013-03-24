class Eventtype < ActiveRecord::Base
  attr_accessible :name
  validates :name,  :presence => true
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
			return find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			return Eventtype.all
		end
	end
end
