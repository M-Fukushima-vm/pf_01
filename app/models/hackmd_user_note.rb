class HackmdUserNote
	# include ActiveModel::Model
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

end
