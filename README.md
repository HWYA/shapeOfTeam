######database
- player name
- player position
- club
- headshot
- nationality/place of birth/gps coords
- starting yes/no
- date of game/clubs involved

######goal		
- display map of coords for each starting roster, updated before each game
- minimal
- pretty
- search by club

###### setup
Right now, we run a suite of rake tasks in order to get our data loaded in. Our primary source of information is the German site, [Transfermarkt](http://www.transfermarkt.com/). In terminal after your typical Rails setup, `rails app:reset_and_scrape` will get you a fresh seeding of info. This goes into the `lib/tasks` folder and looks for the `reset_and_scrape.task` file and runs it, which in turn drops the dev database and runs several other scrape and external API tasks.