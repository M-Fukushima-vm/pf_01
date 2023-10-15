module Api::Hackmd::CreateArchive
	extend self

	def call(token, id)
		create_archive(token, id)
	end

	private

	def create_archive(token, id)
		res_list = Api::Hackmd::Request.get_user_notes_list(token).body
		# debugger
		if ( res_list.class == String )
			begin
				raise ApiAccessQuotaError, "APIコール数の上限に達し、リスト取得できませんでした"
			# rescue
				render json: { error: { messages: ['APIコール数の上限に達し、リスト取得できませんでした'] } },
				status: :too_many_requests
			end
		else
			# 閲覧権限：全員のモノだけ抽出
			read_permission_notes = res_list.select{ |item| item['readPermission'] == "guest" }
			archives = []
			# 保存されているArchiveかチェックして、保存されていなければ保存
			read_permission_notes.each do |note|
				note_id = {
					short_id: note["shortId"]
				}
				other_params = {
					title: note["title"],
					link: note["publishLink"],
					user_id: id
				}
				# note_id で検索して
				archive = HackmdArchive.find_or_initialize_by(note_id)
				# 保存されていない(new_record?)場合は、他のパラメータ(other_params)を併せて再保存
				if archive.new_record?
					archive.update!(other_params)
					archives << archive
				end
			end
			archives
		end
	end

end

# 独自例外の定義にStandardErrorを継承(https://blog.toshimaru.net/ruby-standard-error/)
class ApiAccessQuotaError < StandardError; end