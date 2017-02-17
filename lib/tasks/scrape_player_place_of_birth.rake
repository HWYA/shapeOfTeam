require 'nokogiri'
require 'open-uri'

namespace :app do
	task :scrape_player_place_of_birth => :environment do

		url_base = 'http://www.transfermarkt.com'

		club_players = Player.all

		# lengthiest scrape, checking time it takes
		start = Time.now

		puts "Number of players to update: " + club_players.count.to_s

		club_players.each_with_index do |player, i|

			url = url_base + player.profile_link
			doc = Nokogiri::HTML(open(url))

			# wanted some level of check, though hardcoding info_spans[0] and info_spans[1] would work as well
			info_spans = doc.css('span.dataValue>span')

			info_spans.each do |s|
				if s.attributes["itemprop"].value === "birthPlace"
					birth_place = s.content
					player.write_attribute(:place_of_birth, birth_place.to_s)
				else
					# other value being 'nationality'
					nat = s.content
					player.write_attribute(:nationality,nat.to_s)
				end
				player.save!
			end

			puts "Number of players birthplaces updated: #{i + 1}" 
		end

		finish = Time.now

		puts "It took #{finish - start} seconds to get all player POB"
	end
end
