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

ActiveRecord::Schema.define(version: 2019_10_02_140041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.bigint "ISBN"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "publisheddate"
    t.integer "pagecount"
    t.integer "rating"
    t.string "infolink"
    t.string "googleid"
  end

  create_table "owned_books", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_owned_books_on_book_id"
    t.index ["user_id"], name: "index_owned_books_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "owned_book_id"
    t.bigint "requestee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.index ["owned_book_id"], name: "index_trades_on_owned_book_id"
    t.index ["requestee_id"], name: "index_trades_on_requestee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "owned_books", "books"
  add_foreign_key "owned_books", "users"
  add_foreign_key "trades", "owned_books"
end
