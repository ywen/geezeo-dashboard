module Presenters
  class TransactionsList
    include ModelPresenter::Base

    def each_transaction
      sorted_transactions = model.transactions.sort {|a, b| b.posted_at <=> a.posted_at}
      sorted_transactions.each do |transaction|
        yield Transaction.new(transaction)
      end
    end
  end
end

