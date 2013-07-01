class TransactionsController < ApplicationController
  def index
    transaction_list = TransactionList.fetch(params)
    @presenter = Presenters::TransactionList.new(transaction_list)
    render partial: "index"
  end
end
