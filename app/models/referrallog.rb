class Referrallog < ActiveRecord::Base
  belongs_to :referral
  belongs_to :facility
  attr_accessible :count, :date, :facility_id, :referral_id
end
