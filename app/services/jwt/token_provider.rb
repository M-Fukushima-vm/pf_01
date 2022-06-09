# トークンの発行(暗号化変換)
module Jwt::TokenProvider
  extend self

  def call(payload)
    issue_token(payload) # ↓のprivateメソッド issue_token の実行
  end
  
  private
  
  def issue_token(payload) # トークンの発行メソッド
    # Railsの秘密鍵で暗号化
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
  
end