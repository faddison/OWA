class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :visitor
  attr_accessible :event_id, :visitor_id
end
