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

ActiveRecord::Schema.define(version: 20160920172531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_foreign_key "gem_versions", "gem_objects"
end
