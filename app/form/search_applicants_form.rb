class SearchApplicantsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(id, mates)
    # 引数で持ち込んだidのユーザー のfollowerのidだけの配列 を生成して followers_id へ格納
      follower_ids = User.find(id).followers.map {|item| item.id.to_i }
    # Activemodel::Relationオブジェクトで 格納idのUser全て(current_user.follower全て) を配列で返す
      followers = User.where(id: follower_ids)
      # debugger
    # current_user.follower から 相互フォロワーを省いて
    # フォローバック待ちユーザー だけの配列状態にする
      applicants = followers - mates
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