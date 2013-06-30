# {:id=>"f0d01c41-475e-4387-a7fb-8530c94a9ec0", :reference_id=>nil, :transaction_type=>"Debit", :memo=>"GameStop", :balance=>59.99, :posted_at=>"2013-06-19T00:00:00+00:00", :created_at=>"2013-06-19T15:53:53+00:00", :nickname=>"GameStop", :original_name=>"GameStop", :check_number=>nil, :tags=>[{:tag=>{:name=>"Entertainment", :balance=>59.99}}]}

class Transaction < ModelBase
  forward_from_hash :original_name, :memo, :tags

  def debit?
    response_hash[:transaction_type].downcase == "debit"
  end
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
