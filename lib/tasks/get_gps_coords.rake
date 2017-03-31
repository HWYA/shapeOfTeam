namespace :app do
    task :get_gps_coords => :environment do

        require 'httparty'
        require 'json'
        require 'resolv'
        require 'resolv-replace'

        url_base = "https://maps.googleapis.com/maps/api/geocode/json?"

        club_players = Player.all

        start = Time.now 

        club_players.each_with_index do |player, i|
            player.removes_pob_region
            player.strip_nationality    # replaces specified nationalities with ""
            pob = player.return_plus_string(player.place_of_birth)
            nat = player.return_plus_string(player.nationality)

            query = url_base + "address=" + pob + ",+" + nat + "&" + "AIzaSyCtNLoBlmw1b1zUJa10PSXqHu-QII9NpYU"

            # takes unicode and turns it into ascii, strip unneeded accents to ensure Google response
            response = HTTParty.get(URI.encode(I18n.transliterate(query)))

            if response['status'] == 'OK'

                maps_response = JSON.parse(response.body)
                
                location = maps_response['results'][0]['geometry']['location']

                player.write_attribute(:bp_latitude,location['lat'])
                player.write_attribute(:bp_longitude,location['lng'])

                if nat == ""    # overwrites empty string nationalities with proper nation
                    last_index = maps_response['results'][0]['address_components'].length - 1
                    nation = maps_response['results'][0]['address_components'][last_index]['long_name']  # holds nation for eastern bloc players hit with Player.strip_nationality
                    player.write_attribute(:nationality, nation)
                end
                
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