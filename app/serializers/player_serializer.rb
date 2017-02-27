class PlayerSerializer < ActiveModel::Serializer
  attributes :name, :position, :place_of_birth, :nationality, :bp_latitude, :bp_longitude
end
