# require 'rubygems'

task :scrape_players => :environment do

	require 'nokogiri'
	require 'open-uri'

	url_base = 'http://www.transfermarkt.com'

	# statically coded for Man Utd right now
	url = url_base + '/a/kader/verein/985/saison_id/2016'
	doc = Nokogiri::HTML(open(url))

	# prints name, profile link
	player_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.posrela>table>tr>td.hauptlink>div>span.hide-for-small>a.spielprofil_tooltip')

	club = Club.new(name: "Manchester United")

	player_nodes.each do |p|
		profile_link = p.attribute('href').to_s
		name = p.text.to_s


		pl = Player.new(name: name, profile_link: profile_link)
		club.players << pl
		club.save
	end
end