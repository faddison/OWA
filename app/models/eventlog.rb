
class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :visitor
  attr_accessible :event_id, :visitor_id, :ename, :vname, :status, :date
  validates :event_id,  :presence => true
  validates :visitor_id, :presence => true
  
  def self.to_csv(params)
		@records = Eventlog.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end

end
