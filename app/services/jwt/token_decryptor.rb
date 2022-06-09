# 暗号化を解除(=復号…暗号を暗号化前の状態に戻)し、user_authenticator.rbに戻す
module Jwt::TokenDecryptor
  extend self

  def call(token)
    decrypt(token) # ↓のprivateメソッド decrypt の実行
  end
  
  private
  
  def decrypt(token) # トークンの暗号化解除メソッド
    begin # 例外処理
      # Railsの秘密鍵で暗号化解除
      JWT.decode(token, Rails.application.credentials.secret_key_base)
    # エラーが起きた時のアクション
    rescue StandardError # StandardErrorが起きた時
      # 独自の InvalidTokenError を返す ↓↓↓
      raise InvalidTokenError
    end
  end
end

# 独自例外の定義にStandardErrorを継承
class InvalidTokenError < StandardError; end 