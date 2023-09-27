class Api::HackmdArchivesController < ApplicationController
	before_action :authenticate, only: %i[index create]
	
	PAGINATES_PAR = 6

	def index
		# archives = HackmdArchive.where(user_id: current_user.id)
		archives_form = Api::Hackmd::SearchHackmdArchivesForm.new(search_params)
		archives = archives_form.search( current_user.id ).order(updated_at: :desc)
		archives = archives.page(params[:page]).per(PAGINATES_PAR)
		render json: archives, each_serializer: HackmdArchiveSerializer,
														meta: {
															total_pages: archives.total_pages,
															total_count: archives.total_count,
															current_page: archives.current_page
														}
	end


	def create
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		token = Base64.decode64(hackmd_account.api_key)
		begin
			archives = Api::Hackmd::CreateArchive.call(token)
		rescue StandardError
			raise ApiAccessQuotaError, "APIコール数の上限に達した為、データが取得できませんでした"
		end
		render json: archives, each_serializer: HackmdArchiveSerializer
	end

	private

	def search_params
    params[:q]&.permit(:title)
  end

end
