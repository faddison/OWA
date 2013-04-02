namespace :db do
  desc "Erase and fill database"
  task :abbreviation => :environment do
	
	Abbreviation.create(word: 'fname', abbv: 'facility')
	Abbreviation.create(word: 'rname', abbv: 'referral')
	Abbreviation.create(word: 'bname', abbv: 'brochure')
	Abbreviation.create(word: 'ename', abbv: 'event')
	Abbreviation.create(word: 'etname', abbv: 'eventtype')
	Abbreviation.create(word: 'pname', abbv: 'program')
	Abbreviation.create(word: 'vname', abbv: 'visitor')
	
	
	end
end