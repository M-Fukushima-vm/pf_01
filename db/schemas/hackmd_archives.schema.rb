# encoding: utf-8 << 最上段に追記で日本語対応
# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "hackmd_archives", force: :cascade do |t|
  t.string "title", null: false
	t.string "link", null: false
	t.string "short_id", null: false, unique: true
	t.integer "user_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
	t.index ["short_id"], name: "index_hackmd_archives_on_short_id" # short_id に index
	t.index ["user_id", "short_id"], name: "index_hackmd_archives_on_user_id_and_short_id", unique: true # user_id と short_id の組み合わせが一意
end
