class SearchBlockingUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 引数で持ち込んだidのユーザー のブロックしているユーザーの idだけの配列 を生成して blocking_user_ids へ格納
      blocking_user_ids = User.includes(:blocking_users).where(id: id.to_i)
                          .map {|item| item.blocking_users.ids }.flatten
    # debugger
    # Activemodel::Relationオブジェクトで 格納idのUser全て を配列で返す
      # relation = User.includes(:followings, :followers).where(id: blocking_user_ids)
      relation = User.with_attached_avatar.includes(
                        followings: { avatar_attachment: :blob },
                        followers: { avatar_attachment: :blob },
                      ).where(id: blocking_user_ids)
    
    # 持ち込んだ search_params の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = relation.by_name(name) if name.present?
    relation
    # debugger
  end
end