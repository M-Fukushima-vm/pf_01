module Api::Hackmd::GetUserNotes
		extend self

		def call(token, search_params)
			get_user_notes(token, search_params)
		end

		private

		def get_user_notes(token, search_params)
			res_list = Api::Hackmd::Request.get_user_notes_list(token).body
			# 閲覧権限：全員のモノだけ抽出
			read_permission_notes = res_list.select{ |item| item['readPermission'] == "guest" }
			# 'shortId'だけの配列作成
			read_permission_note_ids = read_permission_notes.map{ |obj| obj['shortId'] }
			# ノートデータの取得
			res_notes = []
			read_permission_note_ids.each do |id|
				res_notes << Api::Hackmd::Request.get_user_notes(token, id).body
			end
			# ノートデータの整形
			user_note_datas = res_notes.map{ |obj|
				{
					title: obj['title'],
					link: obj['publishLink'],
					short_id: obj['shortId'],
					content: obj['content'],
				} 
			}
			# (保存しない)モデル化
			get_user_notes = []
			user_note_datas.each do |note|
				note_params = {
					title: note[:title],
					link: note[:link],
					short_id: note[:short_id],
					content: note[:content]
				}
				# debugger
				get_user_notes << HackmdUserNote.new(note_params)
			end
			# SearchUserNotesForm のインスタンス化
			user_notes = []
			get_user_notes.each do |note|
				note_params = {
					title: note[:title],
					link: note[:link],
					short_id: note[:short_id],
					content: note[:content]
				}
				# debugger
				user_notes << Api::Hackmd::SearchUserNotesForm.new(note_params)
			end

			searched_notes = []
			# debugger
			if search_params[:title].present?
				searched_notes = user_notes.select{ |item| item.title.downcase.include?(search_params[:title].downcase) }
				searched_notes
			else
				user_notes
			end
			# debugger

		end

end