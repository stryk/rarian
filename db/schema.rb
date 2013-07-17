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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130717164244) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "ticker"
    t.string   "exchange"
    t.boolean  "active"
    t.integer  "ipo_year"
    t.string   "sector"
    t.string   "industry"
    t.string   "website_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["active"], name: "index_companies_on_active", using: :btree
  add_index "companies", ["exchange"], name: "index_companies_on_exchange", using: :btree
  add_index "companies", ["industry"], name: "index_companies_on_industry", using: :btree
  add_index "companies", ["ipo_year"], name: "index_companies_on_ipo_year", using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree
  add_index "companies", ["sector"], name: "index_companies_on_sector", using: :btree
  add_index "companies", ["ticker"], name: "index_companies_on_ticker", using: :btree

  create_table "quote_imports", force: true do |t|
    t.string   "filename"
    t.string   "signature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.datetime "date_time"
    t.boolean  "closing"
    t.decimal  "price"
    t.decimal  "market_cap"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["date_time"], name: "index_quotes_on_date_time", using: :btree
  add_index "quotes", ["market_cap"], name: "index_quotes_on_market_cap", using: :btree
  add_index "quotes", ["price"], name: "index_quotes_on_price", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
