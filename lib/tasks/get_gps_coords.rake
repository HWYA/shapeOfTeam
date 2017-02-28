namespace :app do
    task :get_gps_coords => :environment do

        require 'httparty'
        require 'json'

        url_base = "https://maps.googleapis.com/maps/api/geocode/json?"

        club_players = Player.all

        start = Time.now 

        club_players.each_with_index do |player, i|
            pob = player.place_of_birth
            player.strip_nationality    # replaces specified nationalities with ""
            nat = player.nationality

            # make sure that we skip over players that TransferMarkt might not have info on / we didn't grab properly for whatever reason
            if pob.nil? || nat.nil?
                next
            end

            if (pob.include? " ")
                pob = player.place_of_birth.gsub(" ","+")
            end

            if (nat.include? " ")
                nat = player.nationality.gsub(" ","+")
            end

            query = url_base + "address=" + pob + ",+" + nat + "&" + "AIzaSyCtNLoBlmw1b1zUJa10PSXqHu-QII9NpYU"

            # takes unicode and turns it into ascii, strip unneeded accents to ensure Google response
            response = HTTParty.get(URI.encode(I18n.transliterate(query)))

            if response['status'] == 'OK'
                location = JSON.parse(response.body)['results'][0]['geometry']['location'] #testing

                player.write_attribute(:bp_latitude,location['lat'])
                player.write_attribute(:bp_longitude,location['lng'])
                player.save!
                print "Player POB long/lat updated: #{i + 1} / #{club_players.count}\r"
            else
                # if we don't have a response from Google Maps for whatever reason, go ahead and go to next player - we can deal with it on our end later on
                next
            end
        end

        finish = Time.now

        puts "\nIt took #{finish - start} seconds to get all player POB coordinates"
    end
end