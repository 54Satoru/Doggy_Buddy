ActiveRecord::Schema.define(version: 2021_02_10_220203) do

  create_table "entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "favorite_cs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_c_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_c_id"], name: "index_favorite_cs_on_post_c_id"
    t.index ["user_id", "post_c_id"], name: "index_favorite_cs_on_user_id_and_post_c_id", unique: true
    t.index ["user_id"], name: "index_favorite_cs_on_user_id"
  end

  create_table "favorite_sitters", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_sitter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_sitter_id"], name: "index_favorite_sitters_on_post_sitter_id"
    t.index ["user_id", "post_sitter_id"], name: "index_favorite_sitters_on_user_id_and_post_sitter_id", unique: true
    t.index ["user_id"], name: "index_favorite_sitters_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.text "content"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "room_id"
    t.integer "message_id"
    t.integer "post_c_id"
    t.integer "post_sitter_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_cs", force: :cascade do |t|
    t.string "title"
    t.string "region"
    t.string "datetime"
    t.string "price"
    t.string "payment"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_post_cs_on_user_id"
  end

  create_table "post_sitters", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "region"
    t.string "datetime"
    t.string "price"
    t.string "payment"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["user_id"], name: "index_post_sitters_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "rate"
    t.text "content"
    t.string "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "reviewee_id", null: false
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.text "profile"
    t.string "profile_image_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "entries", "rooms"
  add_foreign_key "entries", "users"
  add_foreign_key "favorite_cs", "post_cs"
  add_foreign_key "favorite_cs", "users"
  add_foreign_key "favorite_sitters", "post_sitters"
  add_foreign_key "favorite_sitters", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "post_cs", "users"
  add_foreign_key "post_sitters", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "rooms", "users"
end
