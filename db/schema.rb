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

ActiveRecord::Schema.define(version: 20141030144119) do

  create_table "discussions", force: true do |t|
    t.string   "title"
    t.string   "leader_code"
    t.string   "participant_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "leader_email"
  end

  create_table "questions", force: true do |t|
    t.text     "content"
    t.integer  "discussion_id"
    t.string   "question_status"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["discussion_id"], name: "index_questions_on_discussion_id"

  create_table "survey_responses", force: true do |t|
    t.integer  "survey_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_responses", ["survey_id"], name: "index_survey_responses_on_survey_id"

  create_table "surveys", force: true do |t|
    t.text     "survey_question"
    t.text     "correct_answer"
    t.integer  "discussion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "survey_status"
  end

  add_index "surveys", ["discussion_id"], name: "index_surveys_on_discussion_id"

end
