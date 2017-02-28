class Player < ApplicationRecord
	belongs_to :club, optional: true

	scope :missing_pob, -> { where(place_of_birth: nil) }
end