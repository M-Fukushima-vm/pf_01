class Api::HackmdAccountsController < ApplicationController
	before_action :authenticate, only: %i[index create destroy]

	def index
		# debugger
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		if hackmd_account.present?
			render json: hackmd_account, serializer: HackmdAccountSerializer
		else
			render json: { error: { messages: ['apiキーは登録されていません'] } },
      status: 404
		end
	end

	def create
		# フロントのVueでBase64変換したもので暗号化して保存する ←方針変更
		# 外部apiにアクセスする時にデコードしたものでアクセスする
		# access_api_key = Base64.decode64(target_params[:api_key])
		# debugger
		hackmd_account = HackmdAccount.create!(target_params)
		render json: hackmd_account, serializer: HackmdAccountSerializer
	end

	def destroy
		# debugger
		hackmd_account = HackmdAccount.find(params[:id])
		hackmd_account.destroy!
	end

	private

	def target_params
		params.require(:hackmd_account).permit(:key_name, :api_key, :user_id)
	end
end
