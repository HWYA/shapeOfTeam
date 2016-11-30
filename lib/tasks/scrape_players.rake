# require 'rubygems'

namespace :app do
	task :scrape_players => :environment do

		require 'nokogiri'
		require 'open-uri'

		url_base = 'http://www.transfermarkt.com'

		# statically coded for Man Utd right now
		url = url_base + '/a/kader/verein/985/saison_id/2016'
		doc = Nokogiri::HTML(open(url))

		# prints name, profile link
		player_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.posrela>table>tr>td.hauptlink>div>span.hide-for-small>a.spielprofil_tooltip')

		club = Club.create(name: "Manchester United")

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

			pl = Player.create(name: name, profile_link: profile_link,position:position_array[k])
			club.players << pl
			club.save
		end
	end
end
