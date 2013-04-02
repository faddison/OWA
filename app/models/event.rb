
class Event < ActiveRecord::Base
  belongs_to :program
  belongs_to :eventtype
  belongs_to :facility
  attr_accessible :etname, :fname, :pname, :date, :duration, :eventtype_id, :facility_id, :program_id, :title,:status
  validates :date,  :presence => true
  validates :duration, :presence => true
  validates :eventtype_id,  :presence => true
  validates :facility_id, :presence => true
  validates :program_id,  :presence => true
  validates :title,  :presence => true
  
  has_many :eventlogs, :dependent => :destroy
  
  def self.to_csv(params)
		@records = Event.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
end
