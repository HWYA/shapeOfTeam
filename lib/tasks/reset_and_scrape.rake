namespace :app do
	desc 'clean out db and run our scrape tasks in proper order'
	task :reset_and_scrape => ["db:reset", :scrape_teams, :scrape_players, :scrape_player_place_of_birth, :scrape_gps]
end