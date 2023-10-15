# encoding: utf-8 << 最上段に追記で日本語対応
# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "memos", force: :cascade do |t|
  t.string "title", null: false
	t.string "intro", default: nil
  t.text "content", default: nil
	t.integer "user_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
	t.index ["user_id"], name: "index_memos_on_user_id" # user_id に index
end
