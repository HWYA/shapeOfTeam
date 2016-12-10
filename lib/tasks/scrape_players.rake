namespace :app do
	task :scrape_players => :environment do

		require 'nokogiri'
		require 'open-uri'

		url_base = 'http://www.transfermarkt.com'

		Club.all.each do |c|
			# leaving statically coded version for Man Utd in case we want more manual control over this process
			# url = url_base + '/a/kader/verein/985/saison_id/2016'

			url = url_base + c.club_link

			doc = Nokogiri::HTML(open(url))

			# prints name, profile link
			player_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.posrela>table>tr>td.hauptlink>div>span.hide-for-small>a.spielprofil_tooltip')

			# see comment above
			# club = Club.create(name: "Manchester United")

			position_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.posrela>table>tr')
			position_array = Array.new
			j=0
			position_nodes.each_with_index do |q,i|
				if i % 2 != 0
					position_array[j] = q.text.to_s
					j+=1
				end
			end

			player_nodes.each_with_index do |p,k|
				profile_link = p.attribute('href').to_s
				name = p.text.to_s

				pl = Player.create(name: name, profile_link: profile_link, position: position_array[k])

				# see comment above
				# club.players << pl
				# club.save
				c.players << pl
				c.save
			end
		end
	end
end
