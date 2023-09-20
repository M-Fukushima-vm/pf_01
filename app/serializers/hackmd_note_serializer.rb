class HackmdNoteSerializer < ActiveModel::Serializer
  attributes :title, :link, :short_id, :content

end