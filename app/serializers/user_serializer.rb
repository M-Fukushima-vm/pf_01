class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar_name, :introduction, :avatar_url

  def avatar_url # 追加ここから
    if object.avatar.attached? # 添付されてる時
      # avatar のリンク作成をして返す
      Rails.application.routes.url_helpers.rails_blob_path(object.avatar, only_path: true)
    else
      # 'https://placehold.jp/300x300.png'
    end
  end # ここまで
end