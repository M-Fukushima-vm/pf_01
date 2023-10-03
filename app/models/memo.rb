class Memo < ApplicationRecord
	# アソシエーションの定義
	belongs_to :user
	# バリデーションの定義
	validates :title, presence: true
	validates :user_id, presence: true

	# 検索したい文字列が含まれているレコードを返す
  scope :by_title, ->(title) { where('title LIKE ?', "%#{title}%") }

end
