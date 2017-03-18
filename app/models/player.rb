class Player < ApplicationRecord
	belongs_to :club, optional: true

	scope :missing_pob, -> { where(place_of_birth: nil) }

	def only_have_nationality
		self.place_of_birth.nil? && self.bp_latitude.nil? && bp_longitude.nil?
		self.place_of_birth = ""
	end

	def removes_pob_region
		# avoid entries where place of birth is deliberately set to empty string because TransferMarkt doesn't provide one to us yet
		if self.place_of_birth == ""
			return
		else
			self.place_of_birth = self.place_of_birth.split(',')[0]
			self.save
		end
	end

	def strip_nationality
		deprecated_nations = ["Jugoslawien (SFR)","CSSR","UDSSR","Yugoslavia (Republic)"]
		# we can update nationality from another source
		if deprecated_nations.include?(self.nationality)
			self.nationality = ""
			self.save
		end
	end
end