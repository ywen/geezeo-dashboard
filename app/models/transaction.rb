class Transaction < ModelBase
end

class TransactionsList
  attr_reader :transaction_list_data, :transactions

  class << self
    def fetch(params)
      data = Connector.get :transactions, params[:account_id]
      transactions = data.transactions_array.map{|t| Transaction.new t[:transaction] }
      self.new transactions, data
    end
  end

  def initialize(transactions, transaction_list_data)
    @transactions = transactions
    @transaction_list_data = transaction_list_data
  end
end
