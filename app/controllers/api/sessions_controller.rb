class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    # 条件分岐
    if user&.authenticate(session_params[:password])
      # user.idから一意のuserを特定してtoken生成(token名でインスタンス化)
      token = Jwt::TokenProvider.call(user_id: user.id)
      render json: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer).as_json.deep_merge(user: { token: token })
    else # 取得できなかった(DBに存在が確認できなかった)時
      # jsonで message と unauthorizedステータス を返す
      render json: { error: { messages: ['メールアドレスまたはパスワードに誤りがあります。'] } },
      status: :unauthorized
    end
  end

  private

  # ブラウザからのパラメーターで受け取るデータを定義
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
