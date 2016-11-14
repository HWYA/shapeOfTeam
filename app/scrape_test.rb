require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = 'http://www.transfermarkt.com/manchester-united/kader/verein/985/saison_id/2016'
doc = Nokogiri::HTML(open(url))

player_table = doc.css('table.items')[0]

player_table.css('td').each do |item|
	puts item
end
