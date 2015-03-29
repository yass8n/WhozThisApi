class UserSerializer < ActiveModel::Serializer
  attributes :id, :phone, :first_name, :last_name, :filename
end
