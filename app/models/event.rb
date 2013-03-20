class Event < ActiveRecord::Base
  belongs_to :program
  belongs_to :eventtype
  belongs_to :facility
  attr_accessible :date, :duration, :eventtype_id, :facility_id, :program_id, :title
end
