class Api::Hackmd::SearchArchivesForm

  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string

	def search(id)
		# archives = HackmdArchive.where(user_id: id.to_i)
		archive_ids = User.includes(:hackmd_archives).where(id: id.to_i)
											.map {|item| item.hackmd_archives.ids }.flatten
		relation = HackmdArchive.where(id: archive_ids)
		relation = relation.by_title(title) if title.present?
		relation
	end

end