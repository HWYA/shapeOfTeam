# scrapes all players in database... arguments coming soon

namespace :app do
	task :scrape_player_avatars => :environment do
		require 'nokogiri'
		require 'open-uri'
        require 'thread'
		require 'resolv'
		require 'resolv-replace'

		url_base = 'http://www.transfermarkt.com'

		club_players = Player.all

		start = Time.now

		puts "Number of avatars to update: " + club_players.count.to_s

        work_q = Queue.new
        club_players.each {|player| work_q << player}

        i = 0
        workers = (0..4).map do
            Thread.new do
                begin
                    while player = work_q.pop(true)
                        begin
                            doc = Nokogiri::HTML(open(url_base + player.profile_link))

                            avatar_url = doc.at_css('.dataBild>img').attributes["src"].value
                            avatar_url.prepend("http:")

                            player.avatar_remote_url=(avatar_url)
                            player.save!
                           
                            print "\rNumber of players birthplaces updated: #{i + 1}" 
                            i = i+1
                            
                        rescue => e
                            puts "problem at #{profile_url}"
                            puts e.inspect
                        end
                        
                    end
                rescue ThreadError
                end
            end
        end
        workers.map(&:join)

		finish = Time.now

		puts "\nIt took #{finish - start} seconds to get all player avatars"
	end
end
