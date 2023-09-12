class Api::HackmdAccountsController < ApplicationController
	before_action :authenticate, only: %i[index create destroy]

	def index 
		# api_key 登録専用キーの呼び出し
		save_key = Rails.application.credentials.hackmd[:api_key_save_key]
		render json: save_key
	end

	def create
		debugger
		# HackmdAccount.create!(target_params)

	end

	def destroy
		debugger
	end

	private

	def target_params
		params.requite(:hackmd_account).permit(:key_name, :api_key, :user_id)
	end
end
