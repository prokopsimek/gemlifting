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

ActiveRecord::Schema.define(version: 20170305223235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "gem_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug",        null: false
    t.index ["name", "parent_id"], name: "index_gem_categories_on_name_and_parent_id", unique: true, using: :btree
    t.index ["slug"], name: "index_gem_categories_on_slug", unique: true, using: :btree
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
    t.text     "description"
    t.text     "readme"
    t.string   "git_url"
    t.string   "ssh_url"
    t.integer  "gem_category_id"
    t.datetime "last_commit_at"
    t.index ["gem_category_id"], name: "index_gem_objects_on_gem_category_id", using: :btree
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

  create_table "metric_metrics", force: :cascade do |t|
    t.string   "type"
    t.datetime "measured_at"
    t.integer  "value"
    t.boolean  "transported", default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["measured_at"], name: "index_metric_metrics_on_measured_at", using: :btree
    t.index ["transported"], name: "index_metric_metrics_on_transported", using: :btree
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "proposed_type"
    t.integer  "proposed_id"
    t.text     "note"
    t.string   "proposed_attribute"
    t.text     "proposed_value"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["proposed_type", "proposed_id"], name: "index_proposals_on_proposed_type_and_proposed_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_proposals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["proposal_id"], name: "index_user_proposals_on_proposal_id", using: :btree
    t.index ["user_id", "proposal_id"], name: "index_user_proposals_on_user_id_and_proposal_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_proposals_on_user_id", using: :btree
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
  add_foreign_key "gem_objects", "gem_categories"
  add_foreign_key "gem_versions", "gem_objects"
  add_foreign_key "user_proposals", "proposals"
  add_foreign_key "user_proposals", "users"
end
