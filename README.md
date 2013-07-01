Geezeo Dashboard
====================================

[![Build Status](https://travis-ci.org/ywen/geezeo-dashboard.png?branch=master)](https://travis-ci.org/ywen/geezeo-dashboard)
[![Code Quality](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ywen/geezeo-dashboard)

### Functionality

The following functioanlities have been inplemented:
- A list of the accounts
- The sum of all the account balances
- A list of the latest transactions, and
- A link to allow loading more transactions

### Design

The following text is not meant to be a complete design documentation, rather I would list something I would like to point out for easier understanding.

- The application is a very standard Rails app with one more layer not found in Rails default: a presenter layer. The purpose for a presenter is to provide logic support for presenting data. With a presenter, the view can be made deadly simple.
- I choose to have an ```Account::Persistence``` for persisting account ids and account name because the names are needed for displaying in transaction list. For all my purpose, a simple YAML file suffices

### Screencast

http://youtu.be/nOjUb3H7HfU

# TODO

- The accounts could have different number of transaction pages. Some code could have been written not to call the API to get the account transactions when we know it will returns nothing, which requires the persistence of ```total_page``` and check against it if we should call the API to fetch the next page. But somehow in the example data all 3 accounts have the same pages of transactions
- Page beautification
