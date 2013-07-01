module Presenters
  class TransactionList
    include ModelPresenter::Base
    forward_from_model :has_next_page?, :next_page

    def each_transaction
      sorted_transactions = model.transactions.sort {|a, b| b.posted_at <=> a.posted_at}
      sorted_transactions.each do |transaction|
        yield Transaction.new(transaction)
      end
    end

  end
end

