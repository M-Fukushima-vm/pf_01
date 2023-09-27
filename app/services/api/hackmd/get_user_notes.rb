module Api::Hackmd::GetUserNotes
	extend self

	def call(token, ids, search_params)
		get_user_notes(token, ids, search_params)
	end

	private

	def get_user_notes(token, ids, search_params)
		# ノートデータの取得
			res_notes = []
			# テスト通信
			sample_id = ids.first
			test_data = Api::Hackmd::Request.get_user_notes(token, sample_id).body
		if ( test_data.class == String )
			begin
				raise ApiAccessQuotaError, "APIアクセスのコール上限に達し、ノート取得ができませんでした"
			# rescue
			render json: { error: { messages: ['APIアクセスのコール上限に達し、ノート取得ができませんでした'] } },
			status: :too_many_requests
			end
		else
			ids.each do |id|
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
			if search_params[:title].present?
				searched_notes = user_notes.select{ |item| item.title.downcase.include?(search_params[:title].downcase) }
				searched_notes
			else
				user_notes
			end
			
		end # if~else~
	end # def
end # module

# 独自例外の定義にStandardErrorを継承(https://blog.toshimaru.net/ruby-standard-error/)
class ApiAccessQuotaError < StandardError; end