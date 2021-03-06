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

ActiveRecord::Schema.define(version: 20160613235351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "home"
    t.integer  "away"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "match_pool_id"
    t.index ["match_id"], name: "index_bets_on_match_id", using: :btree
    t.index ["match_pool_id"], name: "index_bets_on_match_pool_id", using: :btree
    t.index ["user_id", "match_id"], name: "index_bets_on_user_id_and_match_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_bets_on_user_id", using: :btree
  end

  create_table "match_pools", force: :cascade do |t|
    t.string   "name"
    t.datetime "bets_opened_at"
    t.datetime "bets_closed_at"
    t.datetime "results_given_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "home"
    t.integer  "away"
    t.datetime "when"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "match_pool_id"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id", using: :btree
    t.index ["home_team_id"], name: "index_matches_on_home_team_id", using: :btree
    t.index ["match_pool_id"], name: "index_matches_on_match_pool_id", using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id"
    t.integer "match_pool_id"
    t.integer "points",        default: 0
    t.boolean "paid",          default: false
    t.index ["match_pool_id"], name: "index_participants_on_match_pool_id", using: :btree
    t.index ["user_id", "match_pool_id"], name: "index_participants_on_user_id_and_match_pool_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_participants_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "auth_token"
    t.string   "remember_digest"
    t.string   "email_token"
    t.boolean  "admin",           default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "bets", "match_pools"
  add_foreign_key "bets", "matches"
  add_foreign_key "bets", "users"
  add_foreign_key "matches", "match_pools"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "participants", "match_pools"
  add_foreign_key "participants", "users"
end
