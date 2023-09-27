class Api::Hackmd::SearchUserNotesForm

  include ActiveModel::Model
  # include ActiveModel::Attributes

  # attribute :title, :string
	# attribute	:link, :string
	# attribute :short_id, :string
	# attribute :content, :string

	# インスタンスに余計なデータがついて見づらいので Virtusで実装 ディスコンだけど

	include Virtus.model
	
	attribute :title, String
	attribute	:link, String
	attribute :short_id, String
	attribute :content, String

	include ActiveModel::Serialization # ActiveRecord::Base を継承しない時 追記

	def active_model_serializer # # ActiveRecord::Base を継承しない時 定義
    ::EntrySerializer
  end

end