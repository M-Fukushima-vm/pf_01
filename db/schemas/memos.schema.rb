# encoding: utf-8 << 最上段に追記で日本語対応
# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "memos", force: :cascade do |t|
  t.string "memo_title", null: false
  t.text "memo_content", default: nil
	t.integer "user_id", null: false
	t.string "note_shortId", default: nil
  t.string "note_title", default: nil
  t.text "note_content", default: nil
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
	t.index ["user_id"], name: "index_memos_on_user_id" # user_id に index
	t.index ["note_shortId"], name: "index_memos_on_note_shortId" # note_shortId に index
	t.index ["user_id", "note_shortId"], name: "index_memos_on_user_id_and_note_shortId", unique: true # user_id と note_shortId の組み合わせが一意
end
