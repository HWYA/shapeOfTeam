namespace :app do
	task :scrape_player_avatars => :environment do
		require 'nokogiri'
		require 'open-uri'
		require 'resolv'
		require 'resolv-replace'

		url_base = 'http://www.transfermarkt.com'

		club_players = Player.all

		start = Time.now

		puts "Number of avatars to update: " + club_players.count.to_s

		club_players.each_with_index do |player, i|

			url = url_base + player.profile_link
			doc = Nokogiri::HTML(open(url))

			avatar_url = doc.at_css('.dataBild>img').attributes["src"].value
            avatar_url.prepend("http:")

            player.avatar_remote_url=(avatar_url)
            player.save!

			print "\rNumber of players birthplaces updated: #{i + 1}" 
		end

		finish = Time.now

		puts "\nIt took #{finish - start} seconds to get all player avatars"
	end
end
