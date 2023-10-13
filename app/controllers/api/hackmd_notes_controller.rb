class Api::HackmdNotesController < ApplicationController
	before_action :authenticate, only: %i[index create destroy]
	
	PAGINATES_PAR = 6

	def index
		# debugger
		notes_form = Api::Hackmd::SearchNotesForm.new(search_params)
		notes = notes_form.search( current_user.id ).order(updated_at: :desc)
		notes = notes.page(params[:page]).per(PAGINATES_PAR)
		render json: notes, each_serializer: HackmdNoteSerializer,
														meta: {
															total_pages: notes.total_pages,
															total_count: notes.total_count,
															current_page: notes.current_page
														}
	end

	def create
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		token = Base64.decode64(hackmd_account.api_key)
		begin
			note = Api::Hackmd::GetUserNote.call(
				token, current_user.id, target_params[:short_id]
			)
			note.save
		rescue StandardError
			raise ApiAccessQuotaError, "APIコール数の上限に達した為、データが取得できませんでした"
		end
		render json: note, serializer: HackmdNoteSerializer
	end

	def update
		# debugger
		note = current_user.hackmd_notes.find(params[:id])
		note.update(target_params)
		render json: note, serializer: HackmdNoteSerializer
		# debugger
	end

	def destroy
		# debugger
		note = current_user.hackmd_notes.find(params[:id])
		note.destroy!
		# debugger
	end

	private

	def target_params
		params.require(:hackmd_note).permit(:id, :title, :short_id, :content,:intro)
	end

	def search_params
		params[:q]&.permit(:title)
	end

end
