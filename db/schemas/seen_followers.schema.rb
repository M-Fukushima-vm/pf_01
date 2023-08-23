# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "seen_followers", force: :cascade do |t|
  t.integer "looked_user_id", null: false
  t.integer "seen_follower_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["seen_follower_id"], name: "index_seen_followers_on_looked_user_id"
  t.index ["seen_follower_id", "looked_user_id"], name: "index_seen_followers_on_seen_follower_id_and_looked_user_id", unique: true
  t.index ["seen_follower_id"], name: "index_seen_followers_on_seen_follower_id"
end