class SearchMatesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 集合：mates を作成
        # 引数で持ち込んだidのユーザー の相互フォローユーザーの idだけの配列 を生成して mates_id へ格納
        mate_ids = User.find(id).mates.map {|item| item.id.to_i }
    # 集合：muting_users を作成
        # 引数で持ち込んだidのユーザー のmuting_userのidだけの配列 を生成して muting_user_ids へ格納
          muting_user_ids = User.find(id).muting_users.map {|item| item.id.to_i }
    # 集合：blocking_users を作成
        # 引数で持ち込んだidのユーザー のblocking_userのidだけの配列 を生成して blocking_user_ids へ格納
          blocking_user_ids = User.find(id).blocking_users.map {|item| item.id.to_i }

    # 差し引きで 抽出したい集合 を定義する
        # 抽出したい集合： selected_ids
          selected_ids = mate_ids - muting_user_ids - blocking_user_ids
    
    # 抽出したい集合だけの Activemodel::Relationオブジェクトにする
      relation = User.where(id: selected_ids)
    # 抽出したい集合の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = relation.by_name(name) if name.present?
    relation
    # debugger
  end
end