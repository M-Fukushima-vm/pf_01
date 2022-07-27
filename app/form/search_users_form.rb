class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search
    relation = User.distinct
    relation = relation.by_name(name) if name.present?
    relation
  end
end