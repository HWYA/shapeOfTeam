class Player < ApplicationRecord
	belongs_to :club, optional: true

	def strip_nationality
		deprecated_nations = ["Jugoslawien (SFR)","CSSR","UDSSR","Yugoslavia"]
		if deprecated_nations.include?(self.nationality)
			self.nationality = ""
			self.save
		end
	end
	
end