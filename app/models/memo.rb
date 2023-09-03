class Memo < ApplicationRecord
	# アソシエーションの定義
	belongs_to :user
	# バリデーションの定義
	validates :memo_title, presence: true
	validates :user_id, presence: true

	# 検索したい文字列が含まれているレコードを返す
  scope :by_memo_title, ->(memo_title) { where('memo_title LIKE ?', "%#{memo_title}%") }

end
