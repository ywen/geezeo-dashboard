class TransactionsController < ApplicationController
  def index
    transaction_list = TransactionsList.fetch(params)
    @presenter = Presenters::TransactionsList.new(transaction_list)
    render partial: "index"
  end
end
