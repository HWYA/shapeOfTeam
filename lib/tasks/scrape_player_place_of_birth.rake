namespace :app do
	task :scrape_player_place_of_birth => :environment do
		require 'nokogiri'
		require 'open-uri'

		url_base = 'http://www.transfermarkt.com'

		club_players = Player.all

		# lengthiest scrape, checking time it takes
		start = Time.now

		puts "Number of players to update: " + club_players.count.to_s

		club_players.each_with_index do |player, i|

			url = url_base + player.profile_link
			doc = Nokogiri::HTML(open(url))

			# wanted some level of check, though hardcoding info_spans[0] and info_spans[1] would work as well
			parent_span = doc.at_css('.hide-for-small>span.dataValue')

			parent_span.children.each do |c|
				if c.name == "img"
					place_of_birth = c.attributes["title"].value
					player.write_attribute(:place_of_birth, place_of_birth)
				end

				if c.name == "span"
					nationality = c.children[0].content
					player.write_attribute(:nationality, nationality)
				end
				player.save!
			end

			print "\rNumber of players birthplaces updated: #{i + 1}" 
		end

		finish = Time.now

		puts "It took #{finish - start} seconds to get all player POB"
	end
end
