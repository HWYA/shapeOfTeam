class Player < ApplicationRecord
	belongs_to :club, optional: true
end