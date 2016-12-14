class PlayerSerializer < ActiveModel::Serializer
  attributes :name, :position, :place_of_birth, :nationality
end
