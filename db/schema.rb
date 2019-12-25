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

ActiveRecord::Schema.define(version: 20191225025402) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                  null: false
    t.integer  "recipe_id",                null: false
    t.text     "text",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["recipe_id"], name: "index_comments_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "recipe_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id",  null: false
    t.string   "image",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_images_on_recipe_id", using: :btree
  end

  create_table "recipe_ingredients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id",                 null: false
    t.text     "ingredients", limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id", using: :btree
  end

  create_table "recipe_methods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id",                null: false
    t.text     "method",     limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["recipe_id"], name: "index_recipe_methods_on_recipe_id", using: :btree
  end

  create_table "recipe_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id",  null: false
    t.string   "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_videos_on_recipe_id", using: :btree
  end

  create_table "recipes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                         null: false
    t.string   "name",                            null: false
    t.integer  "genre_id",                        null: false
    t.integer  "difficulty_id",                   null: false
    t.string   "servers",                         null: false
    t.string   "cookingtime",                     null: false
    t.string   "restingtime",                     null: false
    t.string   "bakingtime",                      null: false
    t.string   "bakingtemperature",               null: false
    t.text     "instruments",       limit: 65535, null: false
    t.text     "cookingpoint",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["user_id"], name: "index_recipes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",               null: false
    t.string   "email",                  null: false
    t.string   "encrypted_password",     null: false
    t.integer  "gender_id",              null: false
    t.integer  "profession_id",          null: false
    t.string   "profile",                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "recipes"
  add_foreign_key "comments", "users"
  add_foreign_key "recipe_images", "recipes"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_methods", "recipes"
  add_foreign_key "recipe_videos", "recipes"
  add_foreign_key "recipes", "users"
end
