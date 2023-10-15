class SearchMemosForm
  include ActiveModel::Model
  include ActiveModel::Attributes

	attribute :title, :string

	def search(id)
		# 引数で持ち込んだidのユーザー のメモから idだけの配列 を生成して memo_ids へ格納
		memo_ids = User.includes(:memos).where(id: id.to_i)
										.map {|item| item.memos.ids }.flatten
		# debugger

		# Activemodel::Relationオブジェクトで 格納idのUser全て を配列で返す
		# relation = User.with_attached_avatar.includes(:memos).where(id: memo_ids)
		relation = Memo.where(id: memo_ids)

		# コントローラーに持ち込んだ target_params の title に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
			relation = relation.by_title(title) if title.present?
			relation
			# debugger
	end

end