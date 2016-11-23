require 'rubygems'
require 'nokogiri'
require 'open-uri'

# scrape /premiere-league/startseite/wettbewerbe/GB1 for premiere league teams/links first
url_base = 'http://www.transfermarkt.com'

url = url_base + '/premier-league/startseite/wettbewerb/GB1'
doc = Nokogiri::HTML(open(url))

team_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.show-for-small>a.vereinprofil_tooltip')

# all this does right now is print the team name + links btw
team_nodes.each do |p|
	team_link = p.attribute('href')
	name = p.text
	puts name + " " +url_base+team_link
end
