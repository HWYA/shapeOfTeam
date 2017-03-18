namespace :app do
	desc 'clean out db and run our scrape tasks in proper order'
	env_based_command = Rails.env
	task :reset_and_scrape => [env_based_command == "development" ? "db:reset" : "db:migrate", :scrape_teams, :scrape_players, :scrape_player_place_of_birth, :scrape_player_missing_pob, :get_gps_coords]
end