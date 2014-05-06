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

ActiveRecord::Schema.define(version: 20140506194455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",              default: 0,     null: false
    t.integer  "down_votes",            default: 0,     null: false
    t.integer  "net_votes",   limit: 2, default: 0
    t.integer  "points",                default: 0
    t.boolean  "offloaded",             default: false
  end

  add_index "answers", ["company_id"], name: "index_answers_on_company_id", using: :btree
  add_index "answers", ["created_at", "net_votes"], name: "index_answers_on_created_at_and_net_votes", using: :btree
  add_index "answers", ["created_at"], name: "index_answers_on_created_at", using: :btree
  add_index "answers", ["net_votes"], name: "index_answers_on_net_votes", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id", "company_id"], name: "index_answers_on_user_id_and_company_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "description"
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file_type"
    t.integer  "file_size_in_kb"
    t.string   "file_name"
    t.string   "attached_file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attached_file_tmp"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree
  add_index "attachments", ["company_id"], name: "index_attachments_on_company_id", using: :btree
  add_index "attachments", ["file_name"], name: "index_attachments_on_file_name", using: :btree
  add_index "attachments", ["file_type"], name: "index_attachments_on_file_type", using: :btree
  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id", using: :btree

  create_table "blips", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "action"
    t.text     "content"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",             default: 0, null: false
    t.integer  "down_votes",           default: 0, null: false
    t.string   "slug"
    t.integer  "net_votes",  limit: 2, default: 0
    t.integer  "points",               default: 0
  end

  add_index "blips", ["company_id"], name: "index_blips_on_company_id", using: :btree
  add_index "blips", ["created_at", "net_votes"], name: "index_blips_on_created_at_and_net_votes", using: :btree
  add_index "blips", ["created_at"], name: "index_blips_on_created_at", using: :btree
  add_index "blips", ["net_votes"], name: "index_blips_on_net_votes", using: :btree
  add_index "blips", ["slug"], name: "index_blips_on_slug", unique: true, using: :btree
  add_index "blips", ["user_id", "company_id"], name: "index_blips_on_user_id_and_company_id", using: :btree
  add_index "blips", ["user_id"], name: "index_blips_on_user_id", using: :btree

  create_table "catalysts", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.text     "content"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",     default: 0
  end

  add_index "catalysts", ["company_id"], name: "index_catalysts_on_company_id", using: :btree
  add_index "catalysts", ["content"], name: "index_catalysts_on_content", using: :btree
  add_index "catalysts", ["created_at"], name: "index_catalysts_on_created_at", using: :btree
  add_index "catalysts", ["date"], name: "index_catalysts_on_date", using: :btree
  add_index "catalysts", ["user_id", "company_id"], name: "index_catalysts_on_user_id_and_company_id", using: :btree
  add_index "catalysts", ["user_id"], name: "index_catalysts_on_user_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["created_at", "commentable_id", "commentable_type"], name: "created_id_type_ix", using: :btree
  add_index "comments", ["created_at"], name: "index_comments_on_created_at", using: :btree
  add_index "comments", ["slug"], name: "index_comments_on_slug", unique: true, using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

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
    t.string   "slug"
    t.boolean  "delta",            default: true
    t.datetime "quote_updated_at", default: '2014-03-11 20:21:44'
  end

  add_index "companies", ["active"], name: "index_companies_on_active", using: :btree
  add_index "companies", ["delta"], name: "index_companies_on_delta", using: :btree
  add_index "companies", ["exchange"], name: "index_companies_on_exchange", using: :btree
  add_index "companies", ["industry"], name: "index_companies_on_industry", using: :btree
  add_index "companies", ["ipo_year"], name: "index_companies_on_ipo_year", using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree
  add_index "companies", ["quote_updated_at"], name: "index_companies_on_quote_updated_at", using: :btree
  add_index "companies", ["sector"], name: "index_companies_on_sector", using: :btree
  add_index "companies", ["slug"], name: "index_companies_on_slug", unique: true, using: :btree
  add_index "companies", ["ticker"], name: "index_companies_on_ticker", using: :btree

  create_table "company_groups", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_groups", ["company_id"], name: "index_company_groups_on_company_id", using: :btree
  add_index "company_groups", ["group_id", "company_id"], name: "index_company_groups_on_group_id_and_company_id", using: :btree
  add_index "company_groups", ["group_id"], name: "index_company_groups_on_group_id", using: :btree
  add_index "company_groups", ["name"], name: "index_company_groups_on_name", using: :btree

  create_table "competitors", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "competitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "net_votes",     limit: 2, default: 0
    t.integer  "up_votes",                default: 0, null: false
    t.integer  "down_votes",              default: 0, null: false
  end

  add_index "competitors", ["company_id", "competitor_id"], name: "index_competitors_on_company_id_and_competitor_id", using: :btree
  add_index "competitors", ["company_id"], name: "index_competitors_on_company_id", using: :btree
  add_index "competitors", ["competitor_id"], name: "index_competitors_on_competitor_id", using: :btree
  add_index "competitors", ["created_at"], name: "index_competitors_on_created_at", using: :btree
  add_index "competitors", ["net_votes"], name: "index_competitors_on_net_votes", using: :btree
  add_index "competitors", ["user_id"], name: "index_competitors_on_user_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["created_at"], name: "index_follows_on_created_at", using: :btree
  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "groups", force: true do |t|
    t.string "name"
    t.string "description"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "median_target_prices", force: true do |t|
    t.integer  "company_id"
    t.integer  "year"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "median_target_prices", ["company_id", "price", "year"], name: "index_median_target_prices_on_company_id_and_price_and_year", using: :btree
  add_index "median_target_prices", ["company_id"], name: "index_median_target_prices_on_company_id", using: :btree
  add_index "median_target_prices", ["created_at"], name: "index_median_target_prices_on_created_at", using: :btree
  add_index "median_target_prices", ["price"], name: "index_median_target_prices_on_price", using: :btree
  add_index "median_target_prices", ["year"], name: "index_median_target_prices_on_year", using: :btree

  create_table "most_active_tickers", force: true do |t|
    t.integer  "company_id"
    t.integer  "no_of_up_votes"
    t.integer  "no_of_down_votes"
    t.integer  "no_of_votes",      limit: 2
    t.date     "active_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "most_active_tickers", ["active_date", "company_id"], name: "index_most_active_tickers_on_active_date_and_company_id", using: :btree
  add_index "most_active_tickers", ["active_date", "no_of_votes"], name: "index_most_active_tickers_on_active_date_and_no_of_votes", using: :btree
  add_index "most_active_tickers", ["active_date"], name: "index_most_active_tickers_on_active_date", using: :btree
  add_index "most_active_tickers", ["company_id"], name: "index_most_active_tickers_on_company_id", using: :btree
  add_index "most_active_tickers", ["created_at"], name: "index_most_active_tickers_on_created_at", using: :btree
  add_index "most_active_tickers", ["no_of_votes"], name: "index_most_active_tickers_on_no_of_votes", using: :btree

  create_table "navigations", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "url"
    t.string   "query_hashs"
    t.string   "model_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitches", force: true do |t|
    t.string   "action"
    t.text     "multimedia_content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",                     default: 0,     null: false
    t.integer  "down_votes",                   default: 0,     null: false
    t.integer  "net_votes",          limit: 2, default: 0
    t.integer  "points",                       default: 0
    t.boolean  "offloaded",                    default: false
    t.string   "slug"
  end

  add_index "pitches", ["action", "company_id", "created_at"], name: "action_company_created_ix", using: :btree
  add_index "pitches", ["action", "company_id"], name: "index_pitches_on_action_and_company_id", using: :btree
  add_index "pitches", ["action"], name: "index_pitches_on_action", using: :btree
  add_index "pitches", ["company_id"], name: "index_pitches_on_company_id", using: :btree
  add_index "pitches", ["created_at"], name: "index_pitches_on_created_at", using: :btree
  add_index "pitches", ["net_votes"], name: "index_pitches_on_net_votes", using: :btree
  add_index "pitches", ["slug"], name: "index_pitches_on_slug", unique: true, using: :btree
  add_index "pitches", ["title"], name: "index_pitches_on_title", using: :btree
  add_index "pitches", ["user_id", "company_id"], name: "index_pitches_on_user_id_and_company_id", using: :btree
  add_index "pitches", ["user_id"], name: "index_pitches_on_user_id", using: :btree

  create_table "questions", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",             default: 0, null: false
    t.integer  "down_votes",           default: 0, null: false
    t.integer  "net_votes",  limit: 2, default: 0
    t.integer  "points",               default: 0
    t.string   "slug"
  end

  add_index "questions", ["company_id"], name: "index_questions_on_company_id", using: :btree
  add_index "questions", ["content"], name: "index_questions_on_content", using: :btree
  add_index "questions", ["created_at"], name: "index_questions_on_created_at", using: :btree
  add_index "questions", ["net_votes"], name: "index_questions_on_net_votes", using: :btree
  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "quote_imports", force: true do |t|
    t.string   "filename"
    t.string   "signature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quote_imports", ["signature"], name: "index_quote_imports_on_signature", using: :btree

  create_table "quotes", force: true do |t|
    t.datetime "date_time"
    t.boolean  "closing"
    t.decimal  "price"
    t.decimal  "market_cap"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "dayshigh",   default: 0.0
    t.decimal  "dayslow",    default: 0.0
    t.decimal  "yearhigh",   default: 0.0
    t.decimal  "yearlow",    default: 0.0
    t.decimal  "change",     default: 0.0
    t.decimal  "volume",     default: 0.0
  end

  add_index "quotes", ["closing"], name: "index_quotes_on_closing", using: :btree
  add_index "quotes", ["company_id", "created_at"], name: "index_quotes_on_company_id_and_created_at", using: :btree
  add_index "quotes", ["company_id"], name: "index_quotes_on_company_id", using: :btree
  add_index "quotes", ["created_at", "closing"], name: "index_quotes_on_created_at_and_closing", using: :btree
  add_index "quotes", ["created_at"], name: "index_quotes_on_created_at", using: :btree
  add_index "quotes", ["date_time"], name: "index_quotes_on_date_time", using: :btree
  add_index "quotes", ["market_cap"], name: "index_quotes_on_market_cap", using: :btree
  add_index "quotes", ["price"], name: "index_quotes_on_price", using: :btree

  create_table "risks", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "risk"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "net_votes",  limit: 2, default: 0
    t.integer  "up_votes",             default: 0, null: false
    t.integer  "down_votes",           default: 0, null: false
    t.integer  "points",               default: 0
  end

  add_index "risks", ["company_id"], name: "index_risks_on_company_id", using: :btree
  add_index "risks", ["created_at"], name: "index_risks_on_created_at", using: :btree
  add_index "risks", ["net_votes"], name: "index_risks_on_net_votes", using: :btree
  add_index "risks", ["risk"], name: "index_risks_on_risk", using: :btree
  add_index "risks", ["user_id"], name: "index_risks_on_user_id", using: :btree

  create_table "s3objects", force: true do |t|
    t.string  "key"
    t.string  "bucket"
    t.string  "checksum"
    t.string  "storable_type"
    t.integer "storable_id"
  end

  add_index "s3objects", ["key"], name: "index_s3objects_on_key", using: :btree
  add_index "s3objects", ["storable_id"], name: "index_s3objects_on_storable_id", using: :btree
  add_index "s3objects", ["storable_type", "storable_id"], name: "index_s3objects_on_storable_type_and_storable_id", using: :btree
  add_index "s3objects", ["storable_type"], name: "index_s3objects_on_storable_type", using: :btree

  create_table "target_prices", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "year"
    t.float    "target_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "target_prices", ["company_id", "year"], name: "index_target_prices_on_company_id_and_year", using: :btree
  add_index "target_prices", ["company_id"], name: "index_target_prices_on_company_id", using: :btree
  add_index "target_prices", ["user_id"], name: "index_target_prices_on_user_id", using: :btree
  add_index "target_prices", ["year"], name: "index_target_prices_on_year", using: :btree

  create_table "top_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "no_of_up_votes"
    t.integer  "no_of_down_votes"
    t.integer  "no_of_votes",      limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "top_users", ["company_id", "no_of_votes"], name: "index_top_users_on_company_id_and_no_of_votes", using: :btree
  add_index "top_users", ["company_id"], name: "index_top_users_on_company_id", using: :btree
  add_index "top_users", ["created_at"], name: "index_top_users_on_created_at", using: :btree
  add_index "top_users", ["no_of_votes"], name: "index_top_users_on_no_of_votes", using: :btree
  add_index "top_users", ["user_id"], name: "index_top_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",                    null: false
    t.string   "encrypted_password",               default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.integer  "up_votes",                         default: 0,                     null: false
    t.integer  "down_votes",                       default: 0,                     null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                  default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "name"
    t.boolean  "email_user_activity"
    t.boolean  "email_follow_me"
    t.boolean  "email_answer_question"
    t.boolean  "email_comment_reply"
    t.boolean  "email_comment"
    t.boolean  "email_question"
    t.boolean  "email_answer"
    t.integer  "no_day_newsletter"
    t.integer  "password"
    t.integer  "password_confirmation"
    t.integer  "mobilenumber",           limit: 8
    t.string   "image"
    t.string   "aboutuser"
    t.string   "userinterest"
    t.string   "company"
    t.string   "blog"
    t.boolean  "email_company_activity",           default: false
    t.datetime "last_emailed_at",                  default: '2014-01-31 04:33:55'
    t.string   "slug"
    t.boolean  "delta",                            default: true
    t.string   "image_tmp"
    t.boolean  "image_processing"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["down_votes"], name: "index_users_on_down_votes", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["roles_mask"], name: "index_users_on_roles_mask", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["up_votes"], name: "index_users_on_up_votes", using: :btree
  add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree

  create_table "votings", force: true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["created_at"], name: "index_votings_on_created_at", using: :btree
  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], name: "unique_voters", unique: true, using: :btree
  add_index "votings", ["voteable_type", "voteable_id"], name: "index_votings_on_voteable_type_and_voteable_id", using: :btree
  add_index "votings", ["voter_type", "voter_id"], name: "index_votings_on_voter_type_and_voter_id", using: :btree

end
