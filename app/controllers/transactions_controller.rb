class TransactionsController < ApplicationController
  def index
    transaction_list = TransactionList.fetch(params)
    @presenter = Presenters::TransactionList.new(transaction_list)
    response.headers["NextPage"] = @presenter.next_page.to_s
    response.headers["HasNextPage"] = @presenter.has_next_page?.to_s
    partial_name = @presenter.loading_full_page? ? "index" : "rows"
    render partial: partial_name
  end
end
