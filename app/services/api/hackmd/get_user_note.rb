module Api::Hackmd::GetUserNote
	extend self

	def call(token, id, short_id)
		get_user_note(token, id, short_id)
	end

	private

	def get_user_note(token, id, short_id)
		begin
			# ノートデータの取得
			res_note = Api::Hackmd::Request.get_user_note(token, short_id).body
			# 取得ノートデータの整形
			user_note_data = {
				title: res_note['title'],
				link: res_note['publishLink'],
				short_id: res_note['shortId'],
				content: res_note['content']
			} 
			# 取得ノートデータの変換
			html_content = Redcarpet::MdToHtml.change_html(user_note_data[:content])
			# 概要データの生成
			document = Loofah.fragment(html_content)
			clean_text = document.text(encode_special_chars: false)
			intro_data = clean_text.gsub(/\n/, '')[0..149] # 改行文字\nを除いて先頭150文字を抽出
			# 保存用データの整形
			save_data = {
				title: user_note_data[:title],
				link: user_note_data[:link],
				short_id: user_note_data[:short_id],
				user_id: id,
				content: html_content,
				intro: intro_data
			}
			# モデル化
			get_user_note = HackmdNote.new(save_data)

		rescue StandardError
			raise ApiAccessQuotaError
			render json: { error: { messages: ['APIアクセスのコール上限に達し、ノート取得ができませんでした'] } },
			status: :too_many_requests
		end

	end # def
end # module

# 独自例外の定義にStandardErrorを継承(https://blog.toshimaru.net/ruby-standard-error/)
class ApiAccessQuotaError < StandardError; end