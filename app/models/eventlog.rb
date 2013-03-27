
class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :visitor
  attr_accessible :event_id, :visitor_id, :ename, :vname, :status
  validates :event_id,  :presence => true
  validates :visitor_id, :presence => true
  def self.search(search)
		if search
			return find(:all, :conditions => ['ename LIKE ? or vname LIKE ?', "%#{search}%","#{search}"])
		else
			return find(:all)
		end
  end
  def self.to_csv(params)
		@records = Eventlog.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
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