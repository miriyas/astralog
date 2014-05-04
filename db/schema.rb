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

ActiveRecord::Schema.define(version: 20140502194546) do

  create_table "assets", force: true do |t|
    t.integer  "user_id"
    t.string   "filename"
    t.string   "screen_filename"
    t.string   "content_type"
    t.string   "filesize"
    t.string   "dimensions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "parent_id"
    t.string   "view_type"
    t.integer  "posts_count", default: 0
    t.integer  "position"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "body"
    t.string   "user_ip"
    t.string   "role"
    t.string   "status"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "category_id"
    t.integer  "comments_count",     default: 0
    t.string   "title"
    t.text     "body"
    t.string   "tags"
    t.string   "status"
    t.string   "view_type"
    t.integer  "view_count",         default: 0
    t.integer  "main_image"
    t.string   "comment_permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "style"
    t.string   "name"
    t.integer  "categories_count", default: 0
    t.integer  "posts_count",      default: 0
    t.integer  "view_count",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                         null: false
    t.string   "crypted_password",                              null: false
    t.string   "salt",                                          null: false
    t.string   "nickname"
    t.string   "role",                         default: "user"
    t.integer  "posts_count"
    t.integer  "comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

end
