class Api::MemosController < ApplicationController
	before_action :authenticate, only: %i[create destroy]
	def create
		# debugger
		Memo.create!(
			memo_title: target_params[:memo_title],
			memo_content: target_params[:memo_content],
			user_id: current_user.id,
			note_shortId: target_params[:note_shortId],
			note_title: target_params[:note_title],
			note_content: target_params[:note_content]
		)
		# debugger
	end

	def destroy
		debugger
	end

	private

	def target_params
		params.require(:memo).permit(:id, :memo_title, :memo_content, :note_shortId, :note_title, :note_content)
	end
end
