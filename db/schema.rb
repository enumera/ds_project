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

ActiveRecord::Schema.define(:version => 20160101153516) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "region"
    t.string   "alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "iso"
    t.string   "continent"
  end

  create_table "file_stats", :force => true do |t|
    t.integer  "records"
    t.integer  "column_size"
    t.date     "creation_date"
    t.float    "time_to_load"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "time_point_id"
    t.integer  "year_period"
  end

  create_table "fund_records", :force => true do |t|
    t.string   "sector"
    t.string   "fund_name"
    t.integer  "d1"
    t.integer  "d2"
    t.integer  "d3"
    t.integer  "d4"
    t.integer  "d5"
    t.integer  "d6"
    t.integer  "d7"
    t.integer  "d8"
    t.integer  "d9"
    t.integer  "d10"
    t.integer  "d11"
    t.integer  "d12"
    t.float    "wr4"
    t.float    "wr12"
    t.float    "wr26"
    t.integer  "wd4"
    t.integer  "wd12"
    t.integer  "wd26"
    t.integer  "fund_size"
    t.string   "isin"
    t.string   "creation_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "fund_id"
    t.integer  "file_stat_id"
    t.integer  "time_point_id"
    t.float    "next_wd_four"
    t.float    "rate_change"
  end

  create_table "funds", :force => true do |t|
    t.string   "name"
    t.string   "sector"
    t.string   "country_name"
    t.string   "continent"
    t.string   "isin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "country_id"
  end

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "url_safe"
  end

  create_table "time_points", :force => true do |t|
    t.string   "time_period"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
