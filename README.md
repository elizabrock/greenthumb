GreenThumb
==========

The NSS Cohort 5 Intro to Rails Project

[![Build Status](https://travis-ci.org/elizabrock/greenthumb.png?branch=master)](https://travis-ci.org/elizabrock/greenthumb)
[![Code Climate](https://codeclimate.com/github/elizabrock/greenthumb.png)](https://codeclimate.com/github/elizabrock/greenthumb)
[![Code Climate](https://codeclimate.com/github/elizabrock/greenthumb/coverage.png)](https://codeclimate.com/github/elizabrock/greenthumb)

## Ruby Version

* 2.1.2

## System Dependencies

* qt
* libiconv

## Setup and Configuration

1. _Copy_ config/database.yml.example to config/database.yml.
1. _Copy_ config/application.yml.example to config/application.yml.
2. (Optional) Make any changes to database.yml that are necessary for your database setup.
3. Run `rake db:create:all`
4. `rake db:migrate`
5. Run the test suite: `rake`

## Services (job queues, cache servers, search engines, etc.)

None at this time.

## Deployment Instructions

We will fill this in once we deploy the application.
