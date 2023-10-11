class HackmdNoteSerializer < ActiveModel::Serializer
  attributes  :id, :title, :link, :short_id, :content, :intro

end