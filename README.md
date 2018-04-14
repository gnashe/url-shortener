# About the project

This project is a introduction to Rails, and a url-shortener. This project takes inputs of valid, active URLs, and shortens them into smaller URLs. There is a simple user interface to do this, and view all current stored URLs.

# Versions

* Ruby version = 2.5.1
* Rails version = 5.1.6

# Setup
Clone the repo with

`git clone https://github.com/irogi/url-shortener.git && cd url-shortener`

Install all the dependencies by running `bundle install`, and then migrate the database with `rails db:migrate`.

After this is done, start up the rails server with

`rails server`

# Future development
The project has a testing suite to check for valid URLs, and this can be run with `rails test`.

The following additions are currently in progress:

* Expiration of links
* Edit shortened urls

# Author

* Igor Ilic
