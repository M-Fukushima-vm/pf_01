class SearchApplicantsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id)
    # 集合：followers を作成
        # 引数で持ち込んだidのユーザー のfollowerのidだけの配列 を生成して follower_ids へ格納
          follower_ids = User.find(id).followers.map {|item| item.id.to_i }
        # Activemodel::Relationオブジェクトで 格納idのUser全て(current_user.follower全て) を配列で返す
          followers = User.where(id: follower_ids)
    # 集合：mates を作成
        # 引数で持ち込んだidのユーザー のmateのidだけの配列 を生成して mate_ids へ格納
          mate_ids = User.find(id).mates.map {|item| item.id.to_i }
        # Activemodel::Relationオブジェクトで 格納idのUser全て(current_user.mates全て) を配列で返す
          mates = User.where(id: mate_ids)
    # 集合：muting_users を作成
        # 引数で持ち込んだidのユーザー のmuting_userのidだけの配列 を生成して muting_user_ids へ格納
          muting_user_ids = User.find(id).muting_users.map {|item| item.id.to_i }
        # Activemodel::Relationオブジェクトで 格納idのUser全て(current_user.muting_users全て) を配列で返す
          muting_users = User.where(id: muting_user_ids)
    # current_user.followers から 相互フォローのユーザー・ミュートしているユーザーを省いて
    # フォローバック待ちユーザー だけの配列状態にする
      applicants = followers - mates - muting_users
    # idだけの配列を作成して格納
      applicant_ids = applicants.map {|item| item.id.to_i }
    # フォローバック待ちユーザー群だけの Activemodel::Relationオブジェクトにする
      relation = User.where(id: applicant_ids)
    # フォローバック待ちユーザー群の name に値があったら
      # 値の文字列を含むものだけ に relation を置き換える
    relation = relation.by_name(name) if name.present?
    relation
    # debugger
  end
end