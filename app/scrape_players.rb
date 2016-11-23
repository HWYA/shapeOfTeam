require 'rubygems'
require 'nokogiri'
require 'open-uri'

url_base = 'http://www.transfermarkt.com'

# statically coded for Man Utd right now
url = url_base + '/a/kader/verein/985/saison_id/2016'
doc = Nokogiri::HTML(open(url))

# prints name, profile link
player_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.posrela>table>tr>td.hauptlink>div>span.hide-for-small>a.spielprofil_tooltip')
player_nodes.each do |p|
	profile_link = p.attribute('href')
	name = p.text
	puts name + " " + url_base+profile_link
end

# prints nationality, broken atm
# player_nodes = doc.css('div.responsive-table')[0].css('tbody>tr>td.zentriert>img')[0]
# player_nodes.each do |p|
# 	puts p.attribute('title')
# end
