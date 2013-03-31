# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create(email: 'admin@options.bc.ca', password: 'admin123', role_id: '1')
User.create(email: 'coord@options.bc.ca', password: 'coord123', role_id: '2')
User.create(email: 'staff@options.bc.ca', password: 'staff123', role_id: '3')
User.create(email: 'guest@options.bc.ca', password: 'guest123', role_id: '4')

# Roles
Role.create(name: 'Admin')
Role.create(name: 'Coordinator')
Role.create(name: 'Staff')
Role.create(name: 'Guest')

# Facilities
Facility.create(name: 'Surrey', address: '123 Alpha st', status: 'Approved')
Facility.create(name: 'Vancouver', address: '123 Beta st', status: 'Approved')
Facility.create(name: 'Burnaby', address: '123 Gamma st', status: 'Approved')
Facility.create(name: 'Richmond', address: '123 Delta st', status: 'Approved')

# Programs
Program.create(name: 'None', status: 'Approved')
Program.create(name: 'Child Care', status: 'Approved')
Program.create(name: 'Counseling', status: 'Approved')
Program.create(name: 'Housing', status: 'Approved')
Program.create(name: 'Mental Health', status: 'Approved')
Program.create(name: 'Employment', status: 'Approved')
Program.create(name: 'Shelter', status: 'Approved')
Program.create(name: 'Immigration', status: 'Approved')
Program.create(name: 'Stopping the Violence', status: 'Approved')
Program.create(name: 'Youth', status: 'Approved')

# Eventy Types
Eventtype.create(name: 'None', status: 'Approved')
Eventtype.create(name: 'Daily', status: 'Approved')
Eventtype.create(name: 'Weekly', status: 'Approved')
Eventtype.create(name: 'Monthly', status: 'Approved')
Eventtype.create(name: 'Program', status: 'Approved')
Eventtype.create(name: 'Staff Meeting', status: 'Approved')

# Brochures
Brochure.create(name: 'Justice', status: 'Approved')
Brochure.create(name: 'Information and Privacy Commmission', status: 'Approved')
Brochure.create(name: 'Legal Information', status: 'Approved')
Brochure.create(name: 'Aboriginal Rights Council', status: 'Approved')
Brochure.create(name: 'Human Rights Reporter', status: 'Approved')
Brochure.create(name: 'NAACP', status: 'Approved')
Brochure.create(name: 'Hatewatch', status: 'Approved')
Brochure.create(name: 'Assembly of First Nations', status: 'Approved')
Brochure.create(name: 'CHRR Race Discrimination', status: 'Approved')
Brochure.create(name: 'Racial Violence', status: 'Approved')

# Referrals
Referral.create(name: 'SCCRR Subsidy', status: 'Approved')
Referral.create(name: 'Health Nurse', status: 'Approved')
Referral.create(name: 'Health Unit', status: 'Approved')
Referral.create(name: 'IDP', status: 'Approved')
Referral.create(name: 'Speech (O.S)', status: 'Approved')
Referral.create(name: 'Settlement & Integration', status: 'Approved')
Referral.create(name: 'Employment Services', status: 'Approved')
Referral.create(name: 'Counseling Services', status: 'Approved')
Referral.create(name: 'Workshop/Courses', status: 'Approved')
Referral.create(name: 'Parks & Rec', status: 'Approved')
Referral.create(name: 'Community Events', status: 'Approved')
Referral.create(name: 'Surrey Public Library', status: 'Approved')
Referral.create(name: 'Grocery Stores', status: 'Approved')
Referral.create(name: 'Transit', status: 'Approved')


