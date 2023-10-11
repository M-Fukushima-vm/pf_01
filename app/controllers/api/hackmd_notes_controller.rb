class Api::HackmdNotesController < ApplicationController
	before_action :authenticate, only: %i[index create destroy]
	
	PAGINATES_PAR = 6

	def index
		debugger
	end

	def create
		debugger
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		token = Base64.decode64(hackmd_account.api_key)
		
	end

	def destroy
		debugger
	end

	private

	def target_params
		params.require(:hackmd_note).permit(:id, :title, :short_id, :content)
	end

	def search_params
		a
	end

end
