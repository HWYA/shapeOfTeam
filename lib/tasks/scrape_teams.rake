require 'nokogiri'
require 'open-uri'

namespace :app do
	task :scrape_teams => :environment do

		# scrape /premiere-league/startseite/wettbewerbe/GB1 for premiere league teams/links first
		url_base = 'http://www.transfermarkt.com'

		url = url_base + '/premier-league/startseite/wettbewerb/GB1'
		doc = Nokogiri::HTML(open(url))

		league_name = doc.css('div.spielername-profil').text

		# gsub left space at beginning and end of string, but we want to get rid of those with lstrip and chomp, respectively
		clean_ln = league_name.gsub(/\s+/, ' ').lstrip.chomp(" ")

		team_nodes = doc.css('td.hauptlink.no-border-links.hide-for-small.hide-for-pad>a.vereinprofil_tooltip')

		# all this does right now is print the team name + links btw
		team_nodes.each do |tn|
			team_link = tn.attribute('href')
			name = tn.text
			puts name + " " +url_base+team_link

			Club.create(name: name, club_link: team_link, league_name: clean_ln)
		end
	end
end
