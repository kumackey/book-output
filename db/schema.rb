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

ActiveRecord::Schema.define(version: 2020_03_15_221408) do

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "googlebooksapi_id", null: false
    t.string "title", null: false
    t.string "author"
    t.string "image"
    t.text "description"
    t.string "buy_link"
    t.bigint "user_id"
    t.date "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["googlebooksapi_id"], name: "index_books_on_googlebooksapi_id", unique: true
    t.index ["user_id", "created_at", "author", "title"], name: "index_books_on_user_id_and_created_at_and_author_and_title"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "choices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "output_id"
    t.string "content", null: false
    t.boolean "is_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["output_id", "is_answer"], name: "index_choices_on_output_id_and_is_answer", unique: true
    t.index ["output_id"], name: "index_choices_on_output_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_likes_on_book_id"
    t.index ["user_id", "book_id"], name: "index_likes_on_user_id_and_book_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_questions_on_book_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
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
  add_foreign_key "choices", "questions", column: "output_id"
  add_foreign_key "likes", "books"
  add_foreign_key "likes", "users"
  add_foreign_key "questions", "books"
  add_foreign_key "questions", "users"
end
