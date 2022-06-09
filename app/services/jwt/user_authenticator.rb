# application_controller.rb に current_userを返す
module Jwt::UserAuthenticator
  extend self
  
  def call(request_headers)
    # 必要データを抜き出す為、一旦 @request_headersへ代入
    @request_headers = request_headers
    begin
      payload, _ = Jwt::TokenDecryptor.call(token)
      User.find(payload['user_id'])
    rescue StandardError # StandardError が起きた時
      nil
    end
  end
  
  private
  
  # @request_headersから authrizationのデータ(tokenのみ)を取得
  def token
    @request_headers['Authorization'].split(' ').last
  end
end