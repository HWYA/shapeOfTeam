namespace :app do
    task :scrape_gps => :environment do

        require 'httparty'
        require 'json'

        url_base = "https://maps.googleapis.com/maps/api/geocode/json?"

        club_players = Player.all

        club_players.each do |player|
            pob = player.place_of_birth
            nat = player.nationality

            if (pob.include? " ")
                pob = player.place_of_birth.gsub(" ","+")
            end

            if (player.nationality.include? " ")
                nat = player.nationality.gsub(" ","+")
            end

            query = url_base + "address=" + pob + ",+" + nat + "&" + "AIzaSyCtNLoBlmw1b1zUJa10PSXqHu-QII9NpYU"

            response = HTTParty.get(URI.encode(query))

            location = JSON.parse(response.body)['results'][0]['geometry']['location'] #testing

            if (location == nil)
                next
            end

            player.write_attribute(:bp_latitude,location['lat'])
            player.write_attribute(:bp_longitude,location['lng'])
            player.save!
        end
    end
end