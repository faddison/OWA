# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'a@b.c', password: '12345678', role_id: '1')

#create visitors
Visitor.create(fname: 'visitor1')
Visitor.create(fname: 'visitor2')


#create referrals
Referral.create(name: 'referral10')
Referral.create(name: 'referral11')


#create  brochure
Brochure.create(name: 'brochure1')