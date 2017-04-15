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

ActiveRecord::Schema.define(version: 20170329191157) do

  create_table "ants", force: :cascade do |t|
    t.string   "set"
    t.integer  "max_it"
    t.integer  "num_ants"
    t.float    "decay_factor"
    t.float    "c_heur"
    t.float    "c_hist"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bees", force: :cascade do |t|
    t.integer  "problem_size"
    t.string   "search_space"
    t.integer  "max_gens"
    t.integer  "num_bees"
    t.integer  "num_sites"
    t.integer  "elite_sites"
    t.integer  "patch_size"
    t.integer  "e_bees"
    t.integer  "o_bees"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
