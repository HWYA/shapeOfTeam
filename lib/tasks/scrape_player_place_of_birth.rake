namespace :app do
	task :scrape_player_place_of_birth => :environment do

		require 'nokogiri'
		require 'open-uri'

		url_base = 'http://www.transfermarkt.com'

		# statically coded to iterate over Man Utd (or whatever team happens to be first on the premier league front page) right now
		club_players = Player.where(club_id:1)

		club_players.each do |player|

			url = url_base + player.profile_link
			doc = Nokogiri::HTML(open(url))

			# wanted some level of check, though hardcoding info_spans[0] and info_spans[1] would work as well
			info_spans = doc.css('span.dataValue>span')

			info_spans.each do |s|
				if s.attributes["itemprop"].value === "birthPlace"
					birth_place = s.content
					player.write_attribute(:place_of_birth, birth_place.to_s)
					player.save!
				else
					# other value being 'nationality'
					# nat = s.content
					# commented out until we add nationality to schema
					# player.write_attribute(:nationality,nat.to_s)

				end
			end
		end

	end
end
