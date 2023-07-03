# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_03_100218) do
  create_table "answers", force: :cascade do |t|
    t.text "reply"
    t.integer "question_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_answers_on_employee_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "currents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "name"
    t.string "role"
    t.integer "manager_id"
    t.string "manager_name"
    t.string "employee_no"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_employees_on_authentication_token", unique: true
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["jti"], name: "index_employees_on_jti", unique: true
    t.index ["manager_id"], name: "index_employees_on_manager_id"
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "self_feedback"
    t.string "month"
    t.integer "manager_id"
    t.string "manager_feedback"
    t.string "comments"
    t.boolean "feedback_submitted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id", null: false
    t.boolean "meeting", default: false
    t.index ["employee_id"], name: "index_feedbacks_on_employee_id"
  end

  create_table "points", force: :cascade do |t|
    t.float "self_score"
    t.string "month"
    t.integer "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "manager_score"
    t.integer "manager_id"
    t.index ["employee_id"], name: "index_points_on_employee_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "query"
    t.integer "employee_id", null: false
    t.boolean "clarified"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "anonymous"
    t.integer "manager_id"
    t.text "answer"
    t.text "opinion"
    t.index ["employee_id"], name: "index_questions_on_employee_id"
  end

  add_foreign_key "answers", "employees"
  add_foreign_key "answers", "questions"
  add_foreign_key "employees", "employees", column: "manager_id"
  add_foreign_key "feedbacks", "employees"
  add_foreign_key "points", "employees"
  add_foreign_key "questions", "employees"
end
