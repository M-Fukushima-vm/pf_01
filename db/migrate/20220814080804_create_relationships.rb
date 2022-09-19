class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false # フォローしたユーザーid
      t.integer :followed_id, null: false # フォローされたユーザーid

      t.timestamps
    end
    add_index :relationships, :follower_id # 追加index
    add_index :relationships, :followed_id # 追加index
    # follower_idとfollowed_idの組み合わせがユニーク
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
