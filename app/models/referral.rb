class Referral < ActiveRecord::Base
  belongs_to :referrallog
  attr_accessible :name
end
