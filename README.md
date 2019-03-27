# Ogallala

Ogallala is a prototype application for managing shared local authority data for cultural heritage institutions (libraries, archives, and museums). It provides the technical infrastructure for the [Rocky Mountain Names project](http://cola.jackflaps.net).

Ogallala consists of a Rails API built on a PostgreSQL database for serving data, and a [VueJS](https://vuejs.org) frontend. Here it is packaged as two Docker containers for local development, but one could choose to run only the Rails API and build their own frontend as well. The API runs on Ruby 2.4.2 and Rails 5.2.2; the frontend runs on Vue 2.6.1 with Webpack 4.

## Installation instructions

Docker is required to run this application as is. You should have Ruby (2.4.2) and Rails (5.2.2) if you plan to run only the backend.

To start, clone this repository, make sure Docker is running on your system, then build the Docker components:

```
docker-compose build
docker-compose run -u root backend bundle
docker-compose run frontend yarn
```

The `docker-compose build` command will pull the Docker postgres image; the `run backend` and `run frontend` commands install the required Ruby (backend) and Javascript (frontend) libraries for each application.

Finally, create your postgres database and populate it with the provided seed data:

```
docker-compose run backend rails db:create
docker-compose run backend rails db:migrate
docker-compose run backend rails db:seed
```

From here you can run `docker-compose up` to start the application.

Log in with the default admin credentials: username _admin@example.com_, password _nebraska_. At this time the application doesn't support creating new users, deleting existing users, or changing passwords. It allows for creating and editing entity records, as well as deleting entity records (from the backend only).

## Finally

Pull requests and comments welcome! For questions e-mail me: kevin [at] jackflaps.net
