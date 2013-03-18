class Event < ActiveRecord::Base
  belongs_to :eventype
  belongs_to :facility
  belongs_to :program
  attr_accessible :date, :duration, :evettype_id, :facility_id, :notes, :program_id, :title
end
