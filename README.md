**[Add CI badge]**

## Introduction
This app is a simple implementation of a ChatBot for a FAQ system. It is capable of interacting with the user to speed up and humanize the answering of common doubts customers/users might have.

**[Visit the app in Heroku (ADD LINK)]**

## Features
* A help command to list all avaliable commands for interacting with the bot.
* Search by categories with hashtags.
* Adding new questions and answers to the FAQ database.

## Technologies
* [Docker](https://docs.docker.com/get-started/)
* [PostgreSQL](https://www.postgresql.org/)
* [Ruby on Rails](http://rubyonrails.org/)
* [TDD aproach](https://en.wikipedia.org/wiki/Test-driven_development)
* [CodeShip (for CI)](https://codeship.com/)


## Setup

At first, you need to setup some configurations after clonning the repo to your local machine.

### 1. Database

If you want to run the app in your machine, you'll need to create your `database.yml` with the following content

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: postgres
  username: postgres

development:
  <<: *default
  database: obcchatbot_development

test:
  <<: *default
  database: obcchatbot_test

production:
  <<: *default
  database: obcchatbot_production

```

### 2. Docker setup

 As we use docker, we have a `docker-compose.yml` for it.

 After creating this file, run the following commands:

 ```sh
 1. docker-compose build
 2. docker-compose run --rm website bundle install
 3. docker-compose run --rm website bundle exec rails db:create
 4. docker-compose run --rm website bundle exec rails db:migrate
 5. docker-compose up
