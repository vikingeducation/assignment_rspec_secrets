# Practice with Integration Testing (Capybara Gem)
========================

In this assignment, I wrote integration tests for the Secrets application provided by the Viking School. Identified the happy/sad/bad paths for the high level user flows through the application. Ie.
- As a visitor, I want to view all secrets
- As a visitor, I want to sign up
- As a signed-in user, I want to be able to edit one of my secrets
- As a signed-in user, I want to be able to delete one of my secrets


## Getting Started

To get the app started locally you'll need to:

1. Clone the repo with `git clone REPO_URL`
2. `cd` into the project
3. Run
  - `$ bundle install`
  - `$ bundle exec rake db:migrate`
  - `$ bundle exec rake db:seed`
(# take a look around the schema file to see how models were created)

4. Start up the console with `rails c` command

## Running the tests

A big part of the functionality is covered by rspec tests which can be run with following command:
```
bundle exec rspec
```


## About the author
[Dariusz Biskupski](http://dariuszbiskupski.com/)

## Acknowledgments

This is an assignment created for [Viking Code School](https://www.vikingcodeschool.com/)
