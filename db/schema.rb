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

ActiveRecord::Schema.define(version: 20160508180054) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.integer  "portfolio_id"
    t.integer  "vehicle_id"
    t.integer  "units"
    t.decimal  "unit_cost"
    t.decimal  "target_price"
    t.decimal  "target_weighting"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "holdings", ["portfolio_id"], name: "index_holdings_on_portfolio_id"
  add_index "holdings", ["vehicle_id"], name: "index_holdings_on_vehicle_id"

  create_table "portfolios", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "capital"
    t.decimal  "cash"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id"

  create_table "stocks", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "last_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_stocks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "occupation"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehicle_histories", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.date     "trade_date"
    t.decimal  "open"
    t.decimal  "volume"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.decimal  "adj_close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vehicle_histories", ["vehicle_id"], name: "index_vehicle_histories_on_vehicle_id"

  create_table "vehicle_prices", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.date     "trade_date"
    t.decimal  "open"
    t.decimal  "volume"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.decimal  "adj_close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "return"
  end

  add_index "vehicle_prices", ["vehicle_id"], name: "index_vehicle_prices_on_vehicle_id"

  create_table "vehicles", force: :cascade do |t|
    t.string   "ticker"
    t.text     "name"
    t.string   "currency"
    t.decimal  "last_price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "return"
    t.decimal  "risk"
    t.decimal  "sharpe_ratio"
    t.decimal  "beta"
    t.decimal  "alpha"
    t.integer  "no_of_prices"
    t.integer  "parent_id"
  end

end
