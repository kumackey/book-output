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

ActiveRecord::Schema.define(version: 2020_02_24_013606) do

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "googlebooksapi_id", null: false
    t.bigint "isbn", null: false
    t.string "title", null: false
    t.string "author", null: false
    t.string "image"
    t.text "description"
    t.string "buyLink"
    t.bigint "user_id"
    t.date "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["googlebooksapi_id"], name: "index_books_on_googlebooksapi_id", unique: true
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
    t.index ["user_id", "created_at", "author", "title"], name: "index_books_on_user_id_and_created_at_and_author_and_title"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "users"
end
