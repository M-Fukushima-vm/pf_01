class Api::HackmdUserNotesController < ApplicationController
	before_action :authenticate, only: %i[index]
	
	PAGINATES_PAR = 6

	def index
			if (current_user.id == 1)
				user_note_datas = [
					{
						"title": "ChatGPTのTIPS",
						"link": "BJXkAHgy2",
						"short_id": "BJXkAHgy2",
						"content": "ChatGPTのユーザー登録 登録方法 ( youtube ) このページ を開く → 初めてSign up 2回目以降Login E-mailアドレスの登録 入力項目 E-mailアドレス パスワード 入力したらContinue"
					},
					{
						"title": "Markdown quick start guide",
						"link": "rkvWJfndc",
						"short_id": "rkvWJfndc",
						"content": "Welcome to HackMD! :tada: This note will get you started on writing in Markdown in no time. You can try things out right in this note as a playground or leave it in your workspace as a cheatsheet."
					},
					{
						"title": "Test1",
						"link": "test1",
						"short_id": "test1",
						"content": "test1"
					},
					{
						"title": "Test2",
						"link": "test2",
						"short_id": "test2",
						"content": "test2"
					},
					{
						"title": "Test3",
						"link": "test3",
						"short_id": "test3",
						"content": "test3"
					},
					{
						"title": "Test4",
						"link": "test4",
						"short_id": "test4",
						"content": "test4"
					},
					{
						"title": "Test5",
						"link": "test5",
						"short_id": "test5",
						"content": "test5"
					},
				]
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
					user_notes = searched_notes
				else
					user_notes
				end
			end
		notes = Kaminari.paginate_array(user_notes).page(params[:page]).per(PAGINATES_PAR)
		render json: notes, root: "hackmd_notes", each_serializer: HackmdNoteSerializer,
													meta: {
														total_pages: notes.total_pages,
														total_count: notes.total_count,
														current_page: notes.current_page
													}
		# debugger

		# hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		# token = Base64.decode64(hackmd_account.api_key)
		# begin
		# 	user_notes_list_ids = Api::Hackmd::GetUserNotesList.call(token)
		# 	user_notes = Api::Hackmd::GetUserNotes.call(token, user_notes_list_ids,  search_params) #.order(title: :asc)
		# rescue StandardError
		# 	raise ApiAccessQuotaError, "APIアクセスのコール上限に達しました"
		# end
		# notes = Kaminari.paginate_array(user_notes).page(params[:page]).per(PAGINATES_PAR)
		# render json: notes, root: "hackmd_notes", each_serializer: HackmdNoteSerializer,
		# 											meta: {
		# 												total_pages: notes.total_pages,
		# 												total_count: notes.total_count,
		# 												current_page: notes.current_page
		# 											}
		# debugger

		# hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		# token = Base64.decode64(hackmd_account.api_key)
		# user_notes_list_ids = Api::Hackmd::GetUserNotesList.call(token)
		# user_notes = Api::Hackmd::GetUserNotes.call(token, user_notes_list_ids,  search_params) #.order(title: :asc)
		# notes = Kaminari.paginate_array(user_notes).page(params[:page]).per(PAGINATES_PAR)
		# render json: notes, root: "hackmd_notes", each_serializer: HackmdNoteSerializer,
		# 											meta: {
		# 												total_pages: notes.total_pages,
		# 												total_count: notes.total_count,
		# 												current_page: notes.current_page
		# 											}
		# debugger
	end

	private

	def search_params
    params[:q]&.permit(:title)
  end
end
