# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_27_093401) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "collection_games", force: :cascade do |t|
    t.datetime "added_at"
    t.integer "collection_id", null: false
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.text "note"
    t.datetime "updated_at", null: false
    t.index ["collection_id", "game_id"], name: "index_collection_games_on_collection_id_and_game_id", unique: true
    t.index ["collection_id"], name: "index_collection_games_on_collection_id"
    t.index ["game_id"], name: "index_collection_games_on_game_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "collection_type"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "developers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "website"
  end

  create_table "dlcs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "dlc_type"
    t.integer "game_id", null: false
    t.boolean "is_required"
    t.integer "recommended_order"
    t.date "release_date"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_dlcs_on_game_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_developers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "developer_id", null: false
    t.integer "game_id", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_game_developers_on_developer_id"
    t.index ["game_id", "developer_id"], name: "index_game_developers_on_game_id_and_developer_id", unique: true
    t.index ["game_id"], name: "index_game_developers_on_game_id"
  end

  create_table "game_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "genre_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "genre_id"], name: "index_game_genres_on_game_id_and_genre_id", unique: true
    t.index ["game_id"], name: "index_game_genres_on_game_id"
    t.index ["genre_id"], name: "index_game_genres_on_genre_id"
  end

  create_table "game_modes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "mode_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "mode_id"], name: "index_game_modes_on_game_id_and_mode_id", unique: true
    t.index ["game_id"], name: "index_game_modes_on_game_id"
    t.index ["mode_id"], name: "index_game_modes_on_mode_id"
  end

  create_table "game_platforms", force: :cascade do |t|
    t.boolean "available"
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "platform_id", null: false
    t.date "release_date"
    t.datetime "updated_at", null: false
    t.index ["game_id", "platform_id"], name: "index_game_platforms_on_game_id_and_platform_id", unique: true
    t.index ["game_id"], name: "index_game_platforms_on_game_id"
    t.index ["platform_id"], name: "index_game_platforms_on_platform_id"
  end

  create_table "game_publishers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "publisher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "publisher_id"], name: "index_game_publishers_on_game_id_and_publisher_id", unique: true
    t.index ["game_id"], name: "index_game_publishers_on_game_id"
    t.index ["publisher_id"], name: "index_game_publishers_on_publisher_id"
  end

  create_table "game_relations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_user_id"
    t.text "description"
    t.integer "game_from_id", null: false
    t.integer "game_to_id", null: false
    t.string "relation_type"
    t.datetime "updated_at", null: false
    t.integer "votes_down"
    t.integer "votes_up"
    t.index ["created_by_user_id"], name: "index_game_relations_on_created_by_user_id"
    t.index ["game_from_id"], name: "index_game_relations_on_game_from_id"
    t.index ["game_to_id"], name: "index_game_relations_on_game_to_id"
  end

  create_table "game_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "tag_id", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["game_id", "tag_id"], name: "index_game_tags_on_game_id_and_tag_id", unique: true
    t.index ["game_id"], name: "index_game_tags_on_game_id"
    t.index ["tag_id"], name: "index_game_tags_on_tag_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "age_rating"
    t.string "cover_filename"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "difficulty"
    t.boolean "has_russian"
    t.integer "playtime_max"
    t.integer "playtime_min"
    t.date "release_date"
    t.string "session_length"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_games_on_slug", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "modes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_modes_on_name", unique: true
  end

  create_table "offers", force: :cascade do |t|
    t.string "activation_type"
    t.boolean "available"
    t.datetime "checked_at"
    t.datetime "created_at", null: false
    t.string "currency"
    t.integer "game_id", null: false
    t.decimal "price"
    t.string "purchase_type"
    t.string "region"
    t.integer "store_id", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["game_id"], name: "index_offers_on_game_id"
    t.index ["store_id"], name: "index_offers_on_store_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "platform_type"
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "body", null: false
    t.string "category"
    t.string "cover_filename"
    t.datetime "created_at", null: false
    t.datetime "published_at"
    t.string "status", default: "draft", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "offer_id", null: false
    t.decimal "price"
    t.datetime "recorded_at"
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_price_histories_on_offer_id"
  end

  create_table "profile_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "genre_id", null: false
    t.integer "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_profile_genres_on_genre_id"
    t.index ["profile_id", "genre_id"], name: "index_profile_genres_on_profile_id_and_genre_id", unique: true
    t.index ["profile_id"], name: "index_profile_genres_on_profile_id"
  end

  create_table "profile_platforms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "platform_id", null: false
    t.integer "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_profile_platforms_on_platform_id"
    t.index ["profile_id", "platform_id"], name: "index_profile_platforms_on_profile_id_and_platform_id", unique: true
    t.index ["profile_id"], name: "index_profile_platforms_on_profile_id"
  end

  create_table "profile_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "profile_id", null: false
    t.integer "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "tag_id"], name: "index_profile_tags_on_profile_id_and_tag_id", unique: true
    t.index ["profile_id"], name: "index_profile_tags_on_profile_id"
    t.index ["tag_id"], name: "index_profile_tags_on_tag_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.boolean "notifications_enabled", default: true, null: false
    t.string "preferred_session_length"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "website"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "rating"
    t.text "text"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["game_id"], name: "index_reviews_on_game_id"
    t.index ["user_id", "game_id"], name: "index_reviews_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "series_games", force: :cascade do |t|
    t.text "chronology_note"
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "order_number"
    t.integer "series_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_series_games_on_game_id"
    t.index ["series_id", "game_id"], name: "index_series_games_on_series_id_and_game_id", unique: true
    t.index ["series_id"], name: "index_series_games_on_series_id"
  end

  create_table "stores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "logo"
    t.string "name"
    t.string "trust_status"
    t.datetime "updated_at", null: false
    t.string "website"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "notifications_consent", default: false, null: false
    t.boolean "personal_data_consent", default: false, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscriptions_on_email", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "user", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "collection_games", "collections"
  add_foreign_key "collection_games", "games"
  add_foreign_key "collections", "users"
  add_foreign_key "dlcs", "games"
  add_foreign_key "game_developers", "developers"
  add_foreign_key "game_developers", "games"
  add_foreign_key "game_genres", "games"
  add_foreign_key "game_genres", "genres"
  add_foreign_key "game_modes", "games"
  add_foreign_key "game_modes", "modes"
  add_foreign_key "game_platforms", "games"
  add_foreign_key "game_platforms", "platforms"
  add_foreign_key "game_publishers", "games"
  add_foreign_key "game_publishers", "publishers"
  add_foreign_key "game_relations", "games", column: "game_from_id"
  add_foreign_key "game_relations", "games", column: "game_to_id"
  add_foreign_key "game_relations", "users", column: "created_by_user_id"
  add_foreign_key "game_tags", "games"
  add_foreign_key "game_tags", "tags"
  add_foreign_key "offers", "games"
  add_foreign_key "offers", "stores"
  add_foreign_key "posts", "users"
  add_foreign_key "price_histories", "offers"
  add_foreign_key "profile_genres", "genres"
  add_foreign_key "profile_genres", "profiles"
  add_foreign_key "profile_platforms", "platforms"
  add_foreign_key "profile_platforms", "profiles"
  add_foreign_key "profile_tags", "profiles"
  add_foreign_key "profile_tags", "tags"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "games"
  add_foreign_key "reviews", "users"
  add_foreign_key "series_games", "games"
  add_foreign_key "series_games", "series"
end
