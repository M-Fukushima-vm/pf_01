module Api::Hackmd::CreateArchive
	extend self

	def call(token)
		create_archive(token)
	end

	private

	def create_archive(token)
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
			# 保存されているArchiveかチェックして、保存されていなければ保存
			read_permission_notes.each do |note|
				note_id = {
					short_id: note[:short_id]
				}
				other_params = {
					title: note[:title],
					link: note[:link],
					user_id: current_user.id
				}
				# note_id で検索して
				archives = HackmdArchive.find_or_initialize_by(note_id)
				# 保存されていない(new_record?)場合は、他のパラメータ(other_params)を併せて再保存
				if archives.new_record?
					archives.update_attributes!(other_params)
				end
			end

		end
	end

end

# 独自例外の定義にStandardErrorを継承(https://blog.toshimaru.net/ruby-standard-error/)
class ApiAccessQuotaError < StandardError; end