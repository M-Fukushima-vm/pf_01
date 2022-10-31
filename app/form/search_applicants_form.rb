class SearchApplicantsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 集合：followers を作成
        # 引数で持ち込んだidのユーザー のfollowerのidだけの配列 を生成して follower_ids へ格納
          follower_ids = User.includes(:followers).where(id: id.to_i)
                              .map {|item| item.followers.ids }.flatten
    # 集合：mates を作成
        # 引数で持ち込んだidのユーザー のmateのidだけの配列 を生成して mate_ids へ格納
          mate_ids = User.includes(:followings, :followers).where(id: id.to_i)
                          .map {|item| item.mates.pluck(:id) }.flatten
    # 集合：muting_users を作成
        # 引数で持ち込んだidのユーザー のmuting_userのidだけの配列 を生成して muting_user_ids へ格納
          muting_user_ids = User.includes(:muting_users).where(id: id.to_i)
                                .map {|item| item.muting_users.ids }.flatten
    # 集合：blocking_users を作成
        # 引数で持ち込んだidのユーザー のblocking_userのidだけの配列 を生成して blocking_user_ids へ格納
          blocking_user_ids = User.includes(:blocking_users).where(id: id.to_i)
                                  .map {|item| item.blocking_users.ids }.flatten
    # debugger
    # 差し引きで 抽出したい集合 を定義する
        # 抽出したい集合： selected_ids
          selected_ids = follower_ids - mate_ids - muting_user_ids - blocking_user_ids
    
    # 抽出したい集合だけの Activemodel::Relationオブジェクトにする
      relation = User.with_attached_avatar.includes(
                        followings: { avatar_attachment: :blob },
                        followers: { avatar_attachment: :blob },
                      ).where(id: selected_ids)
    # 抽出したい集合の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = relation.by_name(name) if name.present?
    relation
    # debugger
  end
end