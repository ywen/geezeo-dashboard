module Presenters
  class TransactionsList
    include ModelPresenter::Base

    def each_transaction
      model.transactions.each do |transaction|
        yield Transaction.new(transaction)
      end
    end
  end
end

