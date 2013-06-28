class Transaction
  class << self
    def fetch(params)
      transactions_array = Connector.get :transactions, params[:account_id]
      transactions_array.map{|t| self.new t }
    end
  end
end
