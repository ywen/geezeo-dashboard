module Accounts
  class TransactionsController < ApplicationController
    def index
      transactions = Transaction.fetch(params)
      @presenters = transactions.map{|transaction| Presenters::Transaction.new(transaction) }
    end
  end
end
