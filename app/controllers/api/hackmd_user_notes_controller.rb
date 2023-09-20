class Api::HackmdUserNotesController < ApplicationController
	before_action :authenticate, only: %i[index]
	
	PAGINATES_PAR = 8

	def index
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		token = Base64.decode64(hackmd_account.api_key)
		user_notes = Api::Hackmd::GetUserNotes.call(token, search_params) #.order(title: :asc)
		# debugger
		notes = Kaminari.paginate_array(user_notes).page(params[:page]).per(PAGINATES_PAR)
		# debugger
		render json: notes, root: "hackmd_notes", each_serializer: HackmdNoteSerializer,
												meta: {
													total_pages: notes.total_pages,
													total_count: notes.total_count,
													current_page: notes.current_page
												}
		# debugger
	end

	private

	def search_params
    params[:q]&.permit(:title)
  end
end
