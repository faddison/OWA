class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :visitor
  attr_accessible :event_id, :visitor_id, :ename, :vname
  
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
end
