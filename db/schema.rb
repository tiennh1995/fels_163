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

ActiveRecord::Schema.define(version: 20160704024735) do

  create_table "activities", force: :cascade do |t|
    t.integer  "action_id"
    t.integer  "activity_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["user_id", "created_at"], name: "index_activities_on_user_id_and_created_at", unique: true
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "answers", force: :cascade do |t|
    t.string   "title"
    t.boolean  "is_correct"
    t.integer  "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answers", ["title", "is_correct", "word_id"], name: "index_answers_on_title_and_is_correct_and_word_id", unique: true
  add_index "answers", ["word_id"], name: "index_answers_on_word_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id"
  add_index "follows", ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id"

  create_table "lessons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.boolean  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id"
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id"

  create_table "results", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "word_id"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id"
  add_index "results", ["lesson_id"], name: "index_results_on_lesson_id"
  add_index "results", ["word_id"], name: "index_results_on_word_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin"
    t.boolean  "is_activated"
    t.string   "avatar"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "users", ["name", "email"], name: "index_users_on_name_and_email", unique: true

  create_table "words", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id"
  add_index "words", ["title", "category_id"], name: "index_words_on_title_and_category_id", unique: true

end
