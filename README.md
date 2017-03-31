[![Build Status](https://travis-ci.org/HWYA/shapeOfTeam.svg?branch=development)](https://travis-ci.org/HWYA/shapeOfTeam)

###### general
shapeOfTeam is a geography and soccer data driven site. Check it out [here](https://shapeofteam.herokuapp.com).

###### setup
Right now, we run a suite of rake tasks in order to get our data loaded in. Our primary source of information is the German site, [Transfermarkt](http://www.transfermarkt.com/). In terminal after your typical Rails setup, `rails app:reset_and_run_tasks` will get you a fresh seeding of info. This goes into the `lib/tasks` folder and looks for the `reset_and_scrape.task` file and runs it, which in turn drops the dev database and runs several other scrape and external API tasks.

If you're forking a copy, you can add the necessary remotes for prod and upstream with the command `chmod u+x ./.add_git_remotes.sh` in terminal. Afterwards, execute the file with `./.add_git_remotes.sh`

###### testing
We run our [RSpec](https://github.com/rspec/rspec) suite with the help of [FactoryGirl](https://github.com/thoughtbot/factory_girl), [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers), and [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner). Our test watcher is [Guard RSpec](https://github.com/guard/guard-rspec).

You can check out the whole suite by running `bundle exec rspec` and passing additional parameters within the `spec` folder like such: `bundle exec rspec spec models/club_spec.rb`

Try running the watcher with `bundle exec guard`