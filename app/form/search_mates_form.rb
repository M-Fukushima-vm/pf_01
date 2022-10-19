class SearchMatesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 集合：mates を作成
        # 引数で持ち込んだidのユーザー の相互フォローユーザーの idだけの配列 を生成して mates_id へ格納
          mate_ids = User.find(id).mates.map {|item| item.id.to_i }
        # Activemodel::Relationオブジェクトで 格納idのUser全て を配列で返す
          # relation = User.where(id: mate_ids)
          mates = User.where(id: mate_ids)
    # 集合：muting_users を作成
        # 引数で持ち込んだidのユーザー のmuting_userのidだけの配列 を生成して muting_user_ids へ格納
          muting_user_ids = User.find(id).muting_users.map {|item| item.id.to_i }
        # Activemodel::Relationオブジェクトで 格納idのUser全て(current_user.muting_users全て) を配列で返す
          muting_users = User.where(id: muting_user_ids)
    # 相互フォローのユーザー から ミュートしているユーザーを省いて
    # 抽出したいユーザー だけの配列状態にする
      select_users = mates - muting_users
    # idだけの配列を作成して格納
      select_user_ids = select_users.map {|item| item.id.to_i }
    # 抽出したいユーザーだけの Activemodel::Relationオブジェクト群 にする
      relation = User.where(id: select_user_ids)
    # 持ち込んだ search_params の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = select_users.by_name(name) if name.present?
    relation
    # debugger
  end
end