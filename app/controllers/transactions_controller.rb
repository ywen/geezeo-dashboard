class TransactionsController < ApplicationController
  def index
    transaction_list = TransactionList.fetch(params)
    @presenter = Presenters::TransactionList.new(transaction_list)
    response.headers["NextPage"] = @presenter.next_page.to_s
    response.headers["HasNextPage"] = @presenter.has_next_page?.to_s
    render partial: "index"
  end
end
