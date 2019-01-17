# Ogallala

Ogallala is a Ruby on Rails application that manages linked local authority data. It provides the technical infrastructure for the [Rocky Mountain Names project](http://cola.jackflaps.net).

Ogallala is built on a Postgres database with an Elasticsearch index. It is tested on Ruby 2.4.2 and Rails 5.2.2.

## Installation instructions

Ogallala requires the following applications to be installed:

* Rails (5.2.2)
* Ruby (2.4.2)
* Elasticsearch
* Yarn (for installing JavaScript libraries)

Once you are set up with the four applications above, follow these instructions:

1. Clone this repository
2. Run `bundle install` to get necessary Ruby gems (if not using postgres, comment out the 'pg' gem to avoid errors)
3. Run `yarn install` to get necessary JavaScript libraries

Then set up your database:

```
rake db:create
rake db:migrate
rake db:seed
```

From here you can run the application normally. `rails server` will do it, though we deploy locally with [Hivemind](https://github.com/DarthSim/hivemind).

Log in with the default admin credentials: username _admin@example.com_, password _nebraska_. Note that, at this time, logging in doesn't actually let you do anything you can't do while not logged in.

## Setting up Postgresql

Ogallala should work with any database application you want to use it with. In development we use Postgresql so that we can [deploy it to Heroku](https://ogallala.herokuapp.com). Here's how to set that up, if you're doing so from scratch on OS X:

```
brew install postgresql
brew services start postgresql
psql postgres
```

And in postgres (setting your password to whatever you specify it to be in `config/database.yml`):

```
CREATE ROLE ogallala WITH LOGIN
ALTER ROLE ogallala NOSUPERUSER CREATEDB
ALTER USER ogallala PASSWORD ${}
```

This app doesn't really work yet so the documentation is extremely poor
