# Hiroikaki

Provides Json API to parse HTML page content and store its content.

## Description

[Hiroikaki](https://hiroikaki.herokuapp.com) provides Json API to parse HTML page content and store its content.

## Features

- Parse HTML page content
- Store parsed content
- Fetch parsed content

## Requirement

- Ruby 2.5.1
- Ruby on Rails 5.2
- Redis Server for Production
- PostgreSQL Server for Production

## Usage

1. GET /Documents

    $ curl "http://localhost:3000/documents"
    
1. POST /Documents

    $ curl -H "Content-Type: application/vnd.api+json" -X POST -d '{"data": {"type":"documents", "attributes":{"url": "https://github.com"}}}' "http://localhost:3000/documents"

1. GET /Documents/:id

    $ curl "http://localhost:3000/documents/1"
    
1. PUT/PATCH /Documents/:id

    $ curl -H "Content-Type: application/vnd.api+json" -X PUT -d '{"data": {"type":"documents", "id":"1", "attributes":{"url": "https://github.com"}}}' "http://localhost:3000/documents/1"

1. DELETE /Documents/:id

    $ curl -X DELETE "http://localhost:3000/documents/1"

## Installation

    $ git clone https://github.com/tomosm/hiroikaki
    $ cd hiroikaki
    $ bundle install
    $ bundle exec rails s

## License

[MIT](http://b4b4r07.mit-license.org)
