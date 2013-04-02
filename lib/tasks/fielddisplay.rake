namespace :db do
  desc "Erase and fill database"
  task :fielddisplay => :environment do
	
	Fielddisplay.create(model: 'referral', field: 'name')
	Fielddisplay.create(model: 'referral', field: 'status')
	Fielddisplay.create(model: 'brochurelog', field: 'date')
	Fielddisplay.create(model: 'brochurelog', field: 'count')
	Fielddisplay.create(model: 'brochurelog', field: 'bname')
	Fielddisplay.create(model: 'brochurelog', field: 'fname')
	Fielddisplay.create(model: 'brochurelog', field: 'status')
	Fielddisplay.create(model: 'brochure', field: 'name')
	Fielddisplay.create(model: 'brochure', field: 'status')
	Fielddisplay.create(model: 'event', field: 'name')
	Fielddisplay.create(model: 'event', field: 'duration')
	Fielddisplay.create(model: 'event', field: 'status')
	Fielddisplay.create(model: 'event', field: 'date')
	Fielddisplay.create(model: 'event', field: 'pname')
	Fielddisplay.create(model: 'event', field: 'fname')
	Fielddisplay.create(model: 'event', field: 'etname')
	Fielddisplay.create(model: 'eventlog', field: 'ename')
	Fielddisplay.create(model: 'eventlog', field: 'date')
	Fielddisplay.create(model: 'eventlog', field: 'vname')
	Fielddisplay.create(model: 'eventlog', field: 'status')
	Fielddisplay.create(model: 'eventtype', field: 'name')
	Fielddisplay.create(model: 'eventtype', field: 'status')
	Fielddisplay.create(model: 'facility', field: 'status')
	Fielddisplay.create(model: 'facility', field: 'name')
	Fielddisplay.create(model: 'facility', field: 'address')
	Fielddisplay.create(model: 'program', field: 'name')
	Fielddisplay.create(model: 'program', field: 'status')
	Fielddisplay.create(model: 'referrallog', field: 'date')
	Fielddisplay.create(model: 'referrallog', field: 'count')
	Fielddisplay.create(model: 'referrallog', field: 'fname')
	Fielddisplay.create(model: 'referrallog', field: 'rname')
	Fielddisplay.create(model: 'referrallog', field: 'status')
	Fielddisplay.create(model: 'user', field: 'email')
	Fielddisplay.create(model: 'user', field: 'role')
	Fielddisplay.create(model: 'user', field: 'last_sign_in_at')
	Fielddisplay.create(model: 'user', field: 'last_sing_in_ip')
	
	end
end