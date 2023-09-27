class Api::HackmdAccountsController < ApplicationController
	before_action :authenticate, only: %i[create destroy]

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
		user = User.includes(:hackmd_account).find(current_user.id)
		account = user.hackmd_account
		account.destroy!
	end

	private

	def target_params
		params.require(:hackmd_account).permit(:key_name, :api_key, :user_id)
	end
end
