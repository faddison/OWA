class Referrallog < ActiveRecord::Base
  belongs_to :facility
  attr_accessible :count, :date
end
