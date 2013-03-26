class Eventtype < ActiveRecord::Base
  attr_accessible :name,:status
  validates :name,  :presence => true
  has_many :events, :dependent => :destroy
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
	def self.connfinal
		establish_connection('finaldb')
	end
	def self.conndeve
		establish_connection('development')
	end
	def approval
		establish_connection('development')
		self.save
		establish_connection('finaldb')
	end
end
