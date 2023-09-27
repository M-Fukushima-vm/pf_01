class ApplicationController < ActionController::Base
  # Railsのsessionを使わない(空にする)
  protect_from_forgery with: :null_session
  
  # 独自例外の定義にStandardErrorを継承
  class AuthenticationError < StandardError; end
	class ApiAccessQuotaError < StandardError; end
  
  # バリデーションエラー(規定例外)処理の設定
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  
	# サーバーエラー(規定例外)処理の設定
	rescue_from StandardError, with: :render_500

  # 非ログイン時のエラー(独自例外)処理の設定
  rescue_from AuthenticationError, with: :not_authenticated

	# 独自例外 APIのコール上限エラー(独自例外)処理の設定
	rescue_from ApiAccessQuotaError, with: :render_429
  
  def current_user # ログインユーザーの取得
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end
  
  def authenticate # 現在ログイン中のuserでなければエラーを発生させる
    raise AuthenticationError unless current_user
  end
  
  private
  
  def render_422(exception) # バリデーションエラー処理
    render json: { error: { messages: exception.record.errors.full_messages } },
    status: :unprocessable_entity
  end
  
  def not_authenticated # 非ログインのエラー処理
    render json: { error: { messages: ['ログインしてください'] } }, status: :unauthorized
  end
  
	def render_500(exception = nil, messages = nil) # Internal サーバーエラー
		# logger.error exception.message
		exception.backtrace.each { |line| logger.error line }
		render_error(500, 'Internal Server Error', exception&.message, *messages)
	end

	def render_429(exception = nil, messages = nil) # APIのコール上限エラー
		logger.error exception.message
		# exception.backtrace.each { |line| logger.error line }
		render_error(:too_many_requests, 'Api Access Quota Error', exception&.message, *messages)
	end


	def render_error(code, message, *error_messages)
    response = {
        message: message,
        errors: error_messages.compact
    }
    render json: response, status: code
  end

end
