Github Search
================

[![Coverage Status](https://coveralls.io/repos/arturo-kon/github-search-rails/badge.png)](https://coveralls.io/r/arturo-kon/github-search-rails)
[![Build Status](https://img.shields.io/travis/arturo-kon/github-search-rails/master.svg)](https://travis-ci.org/arturo-kon/github-search-rails)

App will take a search string and call github api to filter repositories.

Filtering by language is also an option, along with appropriate pagination.

It can sort by stars or forks in ascending or descending order.


Gems
-----------

gem 'sqlite3'  
gem 'sass-rails', '~> 4.0.3'  
gem 'uglifier', '>= 1.3.0'  
gem 'jquery-rails'  
gem 'jbuilder', '~> 2.0'  
gem 'bootstrap-sass'  
gem 'omniauth'  
gem 'omniauth-github'  
gem 'octokit'  
gem 'font-awesome-rails'  

Ruby on Rails
-------------

This application requires:

- Ruby 2.1.2
- Rails 4.1.2


Getting Started
---------------

Simply run:  

``bundle install``  
``rake db:migrate``  
``rake db:seed``  
``rails server``  


