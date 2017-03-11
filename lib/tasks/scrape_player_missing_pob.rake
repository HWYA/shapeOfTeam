namespace :app do
	task :scrape_player_missing_pob => :environment do
		require 'nokogiri'
		require 'open-uri'
		require 'resolv'
		require 'resolv-replace'

		url_base = 'http://www.transfermarkt.com'

		missing_players = Player.missing_pob

		start = Time.now

		puts "Number of players to update: " + missing_players.count.to_s

		missing_players.each_with_index do |player, i|
			url = url_base + player.profile_link
			doc = Nokogiri::HTML(open(url))

			parent_span = doc.at_css('span[itemprop=nationality]')
			nationality = parent_span.content
			player.write_attribute(:nationality, nationality)
			# sets pob to empty string
			player.only_have_nationality
			player.save!

			print "\rNumber of players birthplaces updated: #{i + 1}" 
		end


		finish = Time.now

		puts "\nIt took #{finish - start} seconds to get all player POB"

	end
end
