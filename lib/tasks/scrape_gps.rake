namespace :app do
    task :scrape_gps => :environment do

        require 'httparty'
        require 'json'

        url_base = "https://maps.googleapis.com/maps/api/geocode/json?"

        club_players = Player.all

        club_players.each_with_index do |player, i|
            pob = player.place_of_birth
            nat = player.nationality

            # make sure that we skip over players that TransferMarkt might not have info on / we didn't grab properly for whatever reason
            if pob.nil? || nat.nil?
                next
            end

            if (pob.include? " ")
                pob = player.place_of_birth.gsub(" ","+")
            end

            if (player.nationality.include? " ")
                nat = player.nationality.gsub(" ","+")
            end

            query = url_base + "address=" + pob + ",+" + nat + "&" + "AIzaSyCtNLoBlmw1b1zUJa10PSXqHu-QII9NpYU"

            response = HTTParty.get(URI.encode(query))

            if response['status'] == 'OK'
                location = JSON.parse(response.body)['results'][0]['geometry']['location'] #testing

                player.write_attribute(:bp_latitude,location['lat'])
                player.write_attribute(:bp_longitude,location['lng'])
                player.save!
            else
                next
            end
        end
    end
end