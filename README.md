Prerequisites 
=============

Databases
---------
We're using Postgres for most data, and Redis for queueing.

1. [Install Postgres.app](http://postgresapp.com)
2. [Install Redis from source](http://redis.io/download).

In addition to the Redis instructions on their website, I also like to `mv` the binaries to `/usr/bin`. I also found that I had to create an empty configuration file at `~/.redis/redis.conf`. After this, `redis-server` followed by `redis-client` worked for me.

Ruby
----
We're using JRuby, which I prefer to install via rvm:

1. [Install RVM](https://rvm.io/rvm/install/)
2. Install JRuby 1.7.4: `rvm install jruby-1.7.4`
3. Use JRuby now: `rvm use jruby`
4. Make JRuby the default ruby: `rvm alias create default jruby`

Ruby Gems
---------
We're using Bundler to manage Ruby dependencies and Foreman to run an environment similar to Heroku's locally:

1. `gem install bundler`
2. `gem install foreman`


Installation
============

Setting up the development environment
--------------------------------------

1. Clone this git repository: `git clone git://github.com/louismrose/coco-search.git`
2. `cd coco-search`
3. Run `bundle install` to download all of the Ruby dependencies.
4. Run `rake db:create` then `rake db:migrate` to create the Postgres database and update its schema.
5. cp `.env_example` to `.env`, customising the contents if you wish.


Running the development environment
-----------------------------------

1. Ensure that the database servers are running: you will need to run `redis-server` in a terminal and to make sure that Postrgres.app is running.
2. Run `foreman start` from the application directory. This will create one web thread and one worker thread.

Using the development environment
---------------------------------

1. Visiting [http://localhost:5678](http://localhost:5678) will show the web application.
2. Searches can be created from the web application, or via a JSON API:

Creating a new search:
`curl -H "Content-Type: application/json" -X POST -d '{ "search" : { "grammar" : "a grammar", "evaluation_url" : "http://example.com" } }' http://localhost:5678/searches.json`

Querying a search:
`curl http://localhost:5678/searches/1.json`

Querying all searches:
`curl http://localhost:5678/searches.json`