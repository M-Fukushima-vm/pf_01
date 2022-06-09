class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar_name, :introduction
end