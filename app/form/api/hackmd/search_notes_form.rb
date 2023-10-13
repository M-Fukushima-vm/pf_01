class Api::Hackmd::SearchNotesForm

  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string

	def search(id)
		# archives = HackmdArchive.where(user_id: id.to_i)
		archive_ids = User.includes(:hackmd_notes).where(id: id.to_i)
											.map {|item| item.hackmd_notes.ids }.flatten
		relation = HackmdNote.where(id: archive_ids)
		relation = relation.by_title(title) if title.present?
		relation
	end

end