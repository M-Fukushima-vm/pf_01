class SearchMutingUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 引数で持ち込んだidのユーザー のミュートしているユーザーの idだけの配列 を生成して muting_user_ids へ格納
      muting_user_ids = User.find(id).muting_users.map {|item| item.id.to_i }
    # Activemodel::Relationオブジェクトで 格納idのUser全て を配列で返す
      relation = User.where(id: muting_user_ids)
    # 持ち込んだ search_params の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = relation.by_name(name) if name.present?
    relation
    # debugger
  end
end