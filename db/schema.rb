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

ActiveRecord::Schema.define(version: 20160928135828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gem_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug",        null: false
    t.index ["name"], name: "index_gem_categories_on_name", unique: true, using: :btree
    t.index ["slug"], name: "index_gem_categories_on_slug", unique: true, using: :btree
  end

  create_table "gem_object_in_gem_categories", force: :cascade do |t|
    t.integer  "gem_object_id"
    t.integer  "gem_category_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["gem_category_id"], name: "index_gem_object_in_gem_categories_on_gem_category_id", using: :btree
    t.index ["gem_object_id", "gem_category_id"], name: "index_gem_in_gem_categories_on_gem_id_and_gem_category_id", unique: true, using: :btree
    t.index ["gem_object_id"], name: "index_gem_object_in_gem_categories_on_gem_object_id", using: :btree
  end

  create_table "gem_objects", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "downloads",         default: 0,  null: false
    t.string   "version",                        null: false
    t.integer  "version_downloads", default: 0,  null: false
    t.string   "platform"
    t.string   "authors"
    t.string   "info"
    t.text     "licenses",          default: [],              array: true
    t.string   "sha"
    t.string   "project_uri"
    t.string   "gem_uri"
    t.string   "homepage_uri"
    t.string   "wiki_uri"
    t.string   "documentation_uri"
    t.string   "mailing_list_uri"
    t.string   "source_code_uri"
    t.string   "bug_tracker_uri"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "stargazers_count"
    t.integer  "watchers_count"
    t.integer  "forks_count"
    t.integer  "open_issues_count"
    t.datetime "github_sync_at"
    t.datetime "rubygems_sync_at"
    t.string   "slug",                           null: false
    t.index ["slug"], name: "index_gem_objects_on_slug", unique: true, using: :btree
  end

  create_table "gem_versions", force: :cascade do |t|
    t.integer  "gem_object_id"
    t.string   "authors"
    t.datetime "built_at"
    t.text     "description"
    t.integer  "downloads_count",  default: 0,     null: false
    t.string   "number"
    t.string   "summary"
    t.string   "platfrom"
    t.string   "rubygems_version"
    t.string   "ruby_version"
    t.boolean  "prerelease",       default: false
    t.text     "licenses",         default: [],                 array: true
    t.string   "sha"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["gem_object_id"], name: "index_gem_versions_on_gem_object_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "role",                   default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "gem_categories", "gem_categories", column: "parent_id"
  add_foreign_key "gem_object_in_gem_categories", "gem_categories"
  add_foreign_key "gem_object_in_gem_categories", "gem_objects"
  add_foreign_key "gem_versions", "gem_objects"
end
