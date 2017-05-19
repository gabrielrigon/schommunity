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

ActiveRecord::Schema.define(version: 20170518223418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.integer  "number"
    t.string   "district"
    t.string   "complement"
    t.string   "zipcode"
    t.integer  "linkable_id"
    t.string   "linkable_type"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["linkable_type", "linkable_id"], name: "index_addresses_on_linkable_type_and_linkable_id", using: :btree
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "classroom_times", force: :cascade do |t|
    t.string   "name"
    t.string   "initial"
    t.string   "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classroom_users", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.boolean  "approved",     default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "classroom_users", ["classroom_id"], name: "index_classroom_users_on_classroom_id", using: :btree
  add_index "classroom_users", ["user_id"], name: "index_classroom_users_on_user_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.integer  "institution_id"
    t.integer  "course_id"
    t.integer  "subject_id"
    t.integer  "classroom_time_id"
    t.integer  "representative_id"
    t.integer  "substitute_representative_id"
    t.integer  "teacher_id"
    t.integer  "helper_id"
    t.string   "uuid"
    t.text     "description"
    t.boolean  "active",                       default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "classrooms", ["classroom_time_id"], name: "index_classrooms_on_classroom_time_id", using: :btree
  add_index "classrooms", ["course_id"], name: "index_classrooms_on_course_id", using: :btree
  add_index "classrooms", ["helper_id"], name: "index_classrooms_on_helper_id", using: :btree
  add_index "classrooms", ["institution_id"], name: "index_classrooms_on_institution_id", using: :btree
  add_index "classrooms", ["representative_id"], name: "index_classrooms_on_representative_id", using: :btree
  add_index "classrooms", ["subject_id"], name: "index_classrooms_on_subject_id", using: :btree
  add_index "classrooms", ["substitute_representative_id"], name: "index_classrooms_on_substitute_representative_id", using: :btree
  add_index "classrooms", ["teacher_id"], name: "index_classrooms_on_teacher_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "initials"
    t.text     "description"
    t.integer  "coordinator_id"
    t.integer  "institution_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "courses", ["coordinator_id"], name: "index_courses_on_coordinator_id", using: :btree
  add_index "courses", ["institution_id"], name: "index_courses_on_institution_id", using: :btree

  create_table "genders", force: :cascade do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "company_name"
    t.string   "trading_name"
    t.string   "cnpj"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "post_types", force: :cascade do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "institution_id"
    t.integer  "course_id"
    t.integer  "subject_id"
    t.integer  "classroom_id"
    t.integer  "post_type_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "active"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "posts", ["classroom_id"], name: "index_posts_on_classroom_id", using: :btree
  add_index "posts", ["course_id"], name: "index_posts_on_course_id", using: :btree
  add_index "posts", ["institution_id"], name: "index_posts_on_institution_id", using: :btree
  add_index "posts", ["post_type_id"], name: "index_posts_on_post_type_id", using: :btree
  add_index "posts", ["subject_id"], name: "index_posts_on_subject_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "institution_id"
    t.integer  "course_id"
    t.string   "number"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "students", ["course_id"], name: "index_students_on_course_id", using: :btree
  add_index "students", ["institution_id"], name: "index_students_on_institution_id", using: :btree
  add_index "students", ["user_id"], name: "index_students_on_user_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "initials"
    t.text     "description"
    t.integer  "institution_id"
    t.integer  "course_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subjects", ["course_id"], name: "index_subjects_on_course_id", using: :btree
  add_index "subjects", ["institution_id"], name: "index_subjects_on_institution_id", using: :btree

  create_table "user_chats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.text     "message"
    t.boolean  "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_chats", ["contact_id"], name: "index_user_chats_on_contact_id", using: :btree
  add_index "user_chats", ["user_id"], name: "index_user_chats_on_user_id", using: :btree

  create_table "user_types", force: :cascade do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.integer  "invited_by_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "cpf"
    t.integer  "gender_id"
    t.integer  "user_type_id"
    t.integer  "institution_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["gender_id"], name: "index_users_on_gender_id", using: :btree
  add_index "users", ["institution_id"], name: "index_users_on_institution_id", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", unique: true, using: :btree
  add_index "users", ["invited_by_type"], name: "index_users_on_invited_by_type", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "states"
  add_foreign_key "cities", "states"
  add_foreign_key "classroom_users", "classrooms"
  add_foreign_key "classroom_users", "users"
  add_foreign_key "classrooms", "classroom_times"
  add_foreign_key "classrooms", "courses"
  add_foreign_key "classrooms", "institutions"
  add_foreign_key "classrooms", "subjects"
  add_foreign_key "classrooms", "users", column: "helper_id"
  add_foreign_key "classrooms", "users", column: "representative_id"
  add_foreign_key "classrooms", "users", column: "substitute_representative_id"
  add_foreign_key "classrooms", "users", column: "teacher_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "courses", "institutions"
  add_foreign_key "courses", "users", column: "coordinator_id"
  add_foreign_key "posts", "classrooms"
  add_foreign_key "posts", "courses"
  add_foreign_key "posts", "institutions"
  add_foreign_key "posts", "post_types"
  add_foreign_key "posts", "subjects"
  add_foreign_key "posts", "users"
  add_foreign_key "students", "courses"
  add_foreign_key "students", "institutions"
  add_foreign_key "students", "users"
  add_foreign_key "subjects", "courses"
  add_foreign_key "subjects", "institutions"
  add_foreign_key "user_chats", "users"
  add_foreign_key "user_chats", "users", column: "contact_id"
  add_foreign_key "users", "genders"
  add_foreign_key "users", "institutions"
  add_foreign_key "users", "user_types"
end
