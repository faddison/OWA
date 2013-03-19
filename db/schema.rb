# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130319082330) do

  create_table "brochurelogs", :force => true do |t|
    t.string   "date"
    t.integer  "count"
    t.integer  "facility_id"
    t.integer  "brochure_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "brochurelogs", ["brochure_id"], :name => "index_brochurelogs_on_brochure_id"
  add_index "brochurelogs", ["facility_id"], :name => "index_brochurelogs_on_facility_id"

  create_table "brochures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "eventlogs", :force => true do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "eventlogs", ["event_id"], :name => "index_eventlogs_on_event_id"
  add_index "eventlogs", ["person_id"], :name => "index_eventlogs_on_person_id"

  create_table "events", :force => true do |t|
    t.string   "date"
    t.string   "title"
    t.integer  "evettype_id"
    t.integer  "eventype_id"
    t.integer  "facility_id"
    t.integer  "program_id"
    t.integer  "duration"
    t.string   "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["eventype_id"], :name => "index_events_on_eventype_id"
  add_index "events", ["facility_id"], :name => "index_events_on_facility_id"
  add_index "events", ["program_id"], :name => "index_events_on_program_id"

  create_table "eventtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "language"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "referrallogs", :force => true do |t|
    t.string   "date"
    t.integer  "count"
    t.integer  "referral_id"
    t.integer  "facility_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "referrallogs", ["facility_id"], :name => "index_referrallogs_on_facility_id"
  add_index "referrallogs", ["referral_id"], :name => "index_referrallogs_on_referral_id"

  create_table "referrals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "staffs", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "staffs", ["email"], :name => "index_staffs_on_email", :unique => true
  add_index "staffs", ["reset_password_token"], :name => "index_staffs_on_reset_password_token", :unique => true

end
