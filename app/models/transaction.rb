class Transaction < ModelBase
  forward_from_hash :original_name, :memo, :tags, :account_name

  def posted_at
    response_hash[:posted_at].to_time
  end

  def debit?
    response_hash[:transaction_type].downcase == "debit"
  end
end

class TransactionList
  attr_reader :transaction_list_data, :transactions

  class << self
    def fetch(params)
      all_transactions = []
      all_data = []
      page = params[:page] || 1
      accounts = Account::Persistence.load
      accounts.keys.each do |account_id|
        data = Connector.get :transactions, account_id, page
        all_data << data
        account_name = accounts[account_id.to_i]
        all_transactions << data.transactions_array.map do |t|
          Transaction.new(t[:transaction].merge(account_name: account_name))
        end
      end
      self.new all_transactions.flatten, all_data
    end
  end

  def initialize(transactions, transaction_list_data)
    @transactions = transactions
    @transaction_list_data = transaction_list_data
  end

  def has_next_page?
    has_next_pages = transaction_list_data.map(&:has_next_page?).uniq
    has_next_pages.size > 1 || has_next_pages[0]
  end

  def next_page
    transaction_list_data.empty? ? 1 : transaction_list_data[0].next_page
  end
end
