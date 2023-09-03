class MemoSerializer < ActiveModel::Serializer
  attributes :id, :memo_title, :memo_content, :note_title, :note_content

end