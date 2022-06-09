class ApplicationController < ActionController::Base
  # Railsのsessionを使わない(空にする)
  protect_from_forgery with: :null_session
  
  # 独自例外の定義にStandardErrorを継承
  class AuthenticationError < StandardError; end
  
  # バリデーションエラー(規定例外)処理の設定
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  
  # 非ログイン時のエラー(独自例外)処理の設定
  rescue_from AuthenticationError, with: :not_authenticated
  
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
  
end
